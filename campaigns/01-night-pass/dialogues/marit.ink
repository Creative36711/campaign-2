// Марит, потерявшаяся девочка
// Внешние команды движка объявлены явно — без этого inkjs не соберёт вызовы.
EXTERNAL set_flag(f)
EXTERNAL clear_flag(f)
EXTERNAL add_item(i, n)
EXTERNAL remove_item(i, n)
EXTERNAL fire_rule(r)
EXTERNAL start_quest(q)
EXTERNAL unlock_codex(e)
EXTERNAL unlock_recipe(r)
EXTERNAL change_disposition(n, d)
EXTERNAL apply_status(s, d)
EXTERNAL learn_name(n)
EXTERNAL set_entity_state(n, s)
EXTERNAL play_sound(s, v)
EXTERNAL go_to_scene(s)
EXTERNAL change_scene_state(s)
EXTERNAL set_weather(w)
EXTERNAL start_combat(a)
EXTERNAL skill_check(sk, d)
EXTERNAL sleep(t)
EXTERNAL present_item(ok, fail, item)
EXTERNAL set_dialogue_timer(s, n)
EXTERNAL game_over_victory(t)
EXTERNAL game_over_death(t)
EXTERNAL get_flag(n)
EXTERNAL has_item(i)
EXTERNAL item_count(i)
EXTERNAL get_need(n)
EXTERNAL get_stat(s)
EXTERNAL get_skill(s)
EXTERNAL get_hp()
EXTERNAL get_currency(c)
EXTERNAL get_disposition(n)
EXTERNAL has_status(s)
EXTERNAL quest_stage(q)
EXTERNAL weather_is(w)

-> начало

=== начало ===
Она не отвечает сразу: сначала смотрит, какие у тебя руки. Платок не по размеру, и он не её. # action
Где Саара? Она сказала ждать у огня, а огня нет.
*   [Сказать, что старшую ищешь и ты] -> вместе
*   [Не врать: «не знаю»] -> не_знаю
*   [Отдать ей куклу из санных ящиков] -> кукла
-> DONE

=== вместе ===
Тогда идём к сараю: там пахнет конём, а где конь, там кто-то живой.
~ change_disposition("npc_marit", 6)
-> DONE

=== не_знаю ===
Она кивает, как взрослые кивают на похоронах, и идёт вперёд сама, показывая тебе дорогу.
~ change_disposition("npc_marit", -4)
-> сарай

=== кукла ===
Кукла оказывается кривой и в саже. Она прячет её за пазуху и перестаёт дрожать на минуту.
~ add_item("item_marit_doll", -1)
~ change_disposition("npc_marit", 10)
-> вместе

=== сарай ===
Она идёт к двору почтового дома, не оглядываясь: знает, куда.
~ go_to_scene("scene_oldpost_yard")
-> DONE
