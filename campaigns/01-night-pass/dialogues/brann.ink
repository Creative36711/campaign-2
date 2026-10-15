// Бранн, лекарь заставы
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
Он сушит рукавицы над чужим огнём и считает вслух, кому сколько осталось. # action
Двенадцать, одиннадцать, девять. Не пугайся, это не тебе. У тебя тепло уходит ровно, а у них — с ускорением. # voice: assets/voice/brann_outpost.ogg
*   [Спросить про обморожение] -> обморожение
*   [Попросить помочь с раненой возчицей] -> возчица
*   [Отдать ей паёк] -> паёк
*   [Спросить, что делать с остальными] -> остальные
-> DONE

=== обморожение ===
Признак простой: пальцы перестают слушаться раньше, чем начинают болеть. Как заболели — значит уже не смертельно, а обморожение. Лечится чужим теплом, медленно, и не лечится обещаниями.
~ unlock_codex("codex_pass")
-> DONE

=== возчица ===
Несите на лавку, я завяжу. Потом помой руки, а то у тебя на ладонях уже белое.
*   [Перевязать вместе с ним] -> вместе
*   [Попросить его одного] -> один
-> DONE
=== вместе ===
Узел держит, кожа живая. Завтра она ругается, сегодня молчит: правильно.
~ fire_rule("rule_act_bind")
~ change_disposition("npc_brann", 6)
-> DONE
=== один ===
Он делает это за минуту и злится ровно на минуту.
~ fire_rule("rule_act_bind")
~ set_flag("olita_brought_in")
-> DONE

=== паёк ===
Она съест половину, вторую половину оставит тому, кого вы ведёте. Ты же знаешь, как это работает.
~ remove_item("item_ration", 1)
~ change_disposition("npc_brann", 4)
-> DONE

=== остальные ===
Кого найдёшь — тащи к огню, а не к башне: башня подождёт ровно до свету, а человек не ждёт.
*   [Сказать, что тебе нужен свет на башне] -> спор
*   [Кивнуть и идти] -> кивок
-> DONE
=== спор ===
Он впервые смотрит не на руки, а в лицо. Тогда иди на башню, а я останусь здесь и буду считать.
~ change_disposition("npc_brann", -3)
-> кивок
=== кивок ===
Вот и хорошо. Верёвку не бросай: на мосту она дороже топора.
-> DONE
