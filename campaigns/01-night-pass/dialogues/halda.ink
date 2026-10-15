// Хальда, стряпуха дозора
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
Она ставит перед тобой миску, даже не спросив, голоден ли ты, и отворачивается, чтобы не видеть ответа. # action
Ешь и не благодари: у меня на каждого посчитано. Трое не вернулись с прошлого часа, их порции твои.
*   [Спросить, кого ждёте] -> кого
*   [Попросить забрать миску с собой на склон] -> миска
*   [Сказать, что почтальон придёт с севера] -> север
-> DONE

=== кого ===
Капитана. Он говорит «дозор», а я знаю, что он ждёт, пока кто-то первый скажет, что всех не соберёшь.
~ unlock_codex("codex_pass")
-> DONE

=== миска ===
Она завертывает вcloth и отдаёт, не глядя. На склоне это не еда, а приманка: неси, если не боишься.
~ add_item("item_soup", 1)
~ change_disposition("npc_halda", 6)
-> DONE

=== север ===
Тогда он ещё не пришёл, а время уже потерял. Дверь не заперта, Ивонн не спит.
-> DONE
