// Ивонн, капитан южного дозора
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
Она стоит у стола так, будто уже знает, что придут не все. Лавки заняты не до конца, и это единственное, что она успела заметить. # action
Говори коротко: время, что ты потерял по дороге, я верну только людьми. Бумага есть?
~ present_item("приказ", "нет_приказа", "item_order")
-> DONE

=== приказ ===
Она читает вслух, не меняясь в лице, и складывает лист по сгибам.
Перевал закрыт, дозор выходит на склон. Печать твоя?
*   [Сказать, что печать взята в почтовом доме] -> с_печатью
*   [Сказать, что бумаги достаточно] -> достаточно
-> DONE
=== с_печатью ===
Тогда всё оформлено как следует, и мои люди пойдут не за моим желанием, а за подписью.
~ set_flag("print_taken")
~ set_flag("order_delivered")
~ fire_rule("rule_patrol_moved")
-> финал
=== достаточно ===
Достаточно для меня, недостаточно для конторы. Примечание: почтальон шёл шесть часов и принес то, что мог унести.
~ set_flag("order_delivered")
~ fire_rule("rule_patrol_moved")
-> финал

=== нет_приказа ===
Она не кричит и не злится: она смотрит на дверь, как будто через неё видно склон.
Значит, дозор стоит. Без бумаги я снимаю с поста людей и не знаю, на что.
*   [Предложить зажечь башню своими руками: свет вместо бумаги] -> свет
*   [Назвать имена тех, кто остался на склоне] -> имена
-> DONE
=== свет ===
Если на зубце появится огонь, я выйду и на своё безумие. Иди, я посмотрю в ту сторону.
~ change_disposition("npc_ivonne", 4)
-> финал
=== имена ===
Она записывает имена на поле журнала, и это единственный документ, который у неё есть. Двое пойдут со мной искать.
~ set_flag("people_searched")
~ add_item("item_note", 1)
-> финал

=== финал ===
Сколько людей уцелело на склоне — считай вслух, я запишу цифру и проверю потом.
*   { get_flag("signal_lit") } [Сказать, что свет горит] -> со_светом
*   [Сказать, что света не будет] -> без_света
-> DONE
=== со_светом ===
Огонь виден. Значит, дозор пойдёт на свет, а не в снег. Веди.
~ game_over_victory("Перевал закрыт. Дозор выходит на склон.")
=== без_света ===
Она надевает рукавицы. Тогда пойдём по моим часам, и цифру потерь мы узнаем последней.
~ game_over_victory("Перевал закрыт. Дозор выходит на склон.")
-> DONE
