#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
A1. Расчёт смертельности падения с карниза для пакета 3926804.

Входные данные (все — из пакета campaign-2 @ 3926804 либо из гайда движка):
  * campaign.json: hazards { fall_meters_per_die: 3, fall_damage: "1d6+2" }
  * campaign.json: dice_rules { critical_divisor: 5, special_divisor: 2, fumble_from: 96 }
  * rules/rule_cornice_break.json: hazard_fall {meters: 6, skill: skill_climb} -> change_hp -6
  * campaign.json: duration_actions.act_cross_cornice { min_ticks 1, max_ticks 2, step 1,
                    interrupt_chance_per_tick 0.25, interrupt_rule rule_cornice_break }
  * entities/player_postman.json: skill_climb 40; statuses.status_frostbite: skill_climb -20
  * гайд :2658-2661 — шанс прерывания накапливается: 1-(1-p)^n
  * гайд :691-700 — save_slots/permadeath
  * TD-отчёт (A1_карниз_техническая-проверка_2026-10-16.md), цитата src/core/engine.ts:
        applyFall(): урон = floor(meters / fall_meters_per_die) кубиков d6 (поле fall_damage НЕ читается),
        при успешной проверке навыка урон делится пополам.
        changeHp() при HP<=0 -> gameOver() (автосейв удаляется).
"""
from fractions import Fraction as F

# --- 2d6: сумма двух кубиков ---
W36 = {s: sum(1 for a in range(1, 7) for b in range(1, 7) if a + b == s) for s in range(2, 13)}

def p_die_sum_at_least(k):
    """P(2d6 >= k)"""
    return F(sum(v for s, v in W36.items() if s >= k), 36)

def pct(x):
    return f"{float(x) * 100:.2f} %".replace('.', ',')

def p_interrupt(hours, p=0.25):
    """гайд :2659 — 1-(1-p)^n"""
    return 1 - (1 - p) ** hours

def fall_damage(meters=6, per_die=3, success=False, flat=6):
    """Модель B (движок, по цитате applyFall() из TD-отчёта)."""
    dice = meters // per_die
    tot = 0
    for s, w in W36.items():
        for _ in range(w):
            d = dice
            # d6-кубики: для 2 кубиков сумма 2d6
            pass
    # упрощение: ровно 2 кубика
    assert dice == 2, "модель рассчитана на 2 кубика"
    tot = 0
    dist = {}
    for s, w in W36.items():
        raw = s
        dmg = raw // 2 if success else raw
        dist[dmg] = dist.get(dmg, 0) + w
    return dist, flat

def death_prob(hp, skill, hours, model="engine", flat=6):
    """
    model="engine" (B): applyFall() = 2d6, успех делит пополам, + change_hp -6
    model="package"(A): падение = 2*(1d6+2) = 2d6+4 без деления, + change_hp -6
    """
    p_int = p_interrupt(hours)
    p_fail = 1 - skill / 100.0
    if model == "engine":
        # урон: успех -> 6 + floor(2d6/2) ; провал -> 6 + 2d6
        succ_d = {k: v for k, v in ((6 + s // 2, w) for s, w in W36.items())}
        # сольём веса
        def merge(d):
            out = {}
            for k, v in d.items():
                out[k] = out.get(k, 0) + v
            return out
        succ_d = merge(succ_d)
        fail_d = merge({6 + s: w for s, w in W36.items()})
        p_succ_lethal = F(sum(w for k, w in succ_d.items() if k >= hp), 36)
        p_fail_lethal = F(sum(w for k, w in fail_d.items() if k >= hp), 36)
    else:
        # 2*(1d6+2) = 2d6+4 -> урон 6 + 2d6 + 4; деления нет; "успех = не смертельно"
        fail_d = merge = {}
        w = {}
        for s, cnt in W36.items():
            w[6 + s + 4] = w.get(6 + s + 4, 0) + cnt
        p_succ_lethal = F(0)
        p_fail_lethal = F(sum(v for k, v in w.items() if k >= hp), 36)
    return p_int * (p_fail * p_fail_lethal + (1 - p_fail) * p_succ_lethal), p_int, p_fail, p_fail_lethal

print("=" * 78)
print("A1. Смертельность падения с карниза (6 м) — пакет 3926804")
print("=" * 78)
print()
print("[1] Накопление шанса прерывания (гайд :2659, 1-(1-p)^n), p = 0,25/час")
for h in (1, 2):
    print(f"    {h} ч  ->  {pct(p_interrupt(h))}")
print()
print("[2] Бросок навыка (d100 <= навык; крит- провал с 96, dice_rules пакета)")
for sk in (40, 20):
    print(f"    skill_climb {sk}  ->  успех {sk} %, провал {100 - sk} %")
print()
print("[3] Урон падения")
print("    модель B (движок, applyFall() по TD-цитате): 2d6, успех -> пополам, + change_hp -6")
d_s = {}
for s, w in W36.items():
    d_s[6 + s // 2] = d_s.get(6 + s // 2, 0) + w
d_f = {}
for s, w in W36.items():
    d_f[6 + s] = d_f.get(6 + s, 0) + w
print("      успех  ->", min(d_s), "…", max(d_s), " (среднее", round(sum(k * v for k, v in d_s.items()) / 36, 2), ")")
print("      провал ->", min(d_f), "…", max(d_f), " (среднее", round(sum(k * v for k, v in d_f.items()) / 36, 2), ")")
print("    модель A (пакетное поле fall_damage '1d6+2', как в оценке TGD-1): 2d6+4, + change_hp -6")
d_a = {}
for s, w in W36.items():
    d_a[6 + s + 4] = d_a.get(6 + s + 4, 0) + w
print("      провал ->", min(d_a), "…", max(d_a), " (среднее", round(sum(k * v for k, v in d_a.items()) / 36, 2), ")")
print()
print("[4] P(смерть | попытка) = P(прерывание) x [ P(провал) x P(урон >= HP) + P(успех) x P(урон >= HP) ]")
for model, name in (("engine", "модель B (движок)"), ("package", "модель A (пакет, как у TGD-1)")):
    print(f"\n  --- {name} ---")
    for hp in (15, 13):
        for sk, lab in ((40, "skill_climb 40 (без обморожения)"), (20, "skill_climb 20 (обморожение)")):
            row = []
            for h in (1, 2):
                p, pi, pf, pl = death_prob(hp, sk, h, model)
                row.append(pct(p))
            print(f"    HP {hp:2d} | {lab:34s} | 1 ч: {row[0]:>9s} | 2 ч: {row[1]:>9s}")
print()
print("[5] Контроль: воспроизведение чисел оценки TGD-1 (модель A, HP 13, skill 40/20)")
for sk in (40, 20):
    for h in (1, 2):
        pi = p_interrupt(h); pf = 1 - sk / 100.0
        p = pi * pf * p_die_sum_at_least(3)   # урон >= 13  <=>  2d6 >= 3
        print(f"    skill {sk}, {h} ч: {pct(p)}   (ожидалось TGD-1: "
              f"{ {40:{1:'14,6',2:'25,5'},20:{1:'19,4',2:'34,0'}}[sk][h] } %)")
print()
print("[6] Проверка против фактического прогона TD (HP 15/15 -> 0/15, провал):")
print("    P(2d6 >= 9) =", pct(p_die_sum_at_least(9)), " -> урон 15…18, HP 0 — совместимо")
print("    P(2d6 >= 15) =", pct(p_die_sum_at_least(15)), " (модель A: 0 при 2d6+4+6 <= 22 -> P(2d6>=3)="
      + pct(p_die_sum_at_least(3)) + ")")
