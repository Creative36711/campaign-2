// Тильда, вдова почтового дома
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
Она не спрашивает, кто ты: она смотрит, чистые ли у тебя руки, прежде чем пустить в дом, где и так тесно. # action
Печка моя, дом мой и всё, что в сарае, тоже моё. Говори, за кем пришёл.
*   [Сказать, что за теми, кто в сарае] -> сарай
*   [Спросить про печать почтового дома] -> печать
*   [Попросить только сухое место у печи] -> печь
-> DONE

=== сарай ===
Там старшая держит младшую за руку и не спит. Я бы их уговорила, но я им чужая, а ты с дороги.
~ set_flag("oldpost_barn_found")
-> DONE

=== печать ===
Она достаёт матрицу из-под лавки, не задумываясь: видно, что прятала не от людей, а от себя.
Муж её не вернул, и печать мне не нужна. Отнесёшь в дозор — считай, что дом поработал.
~ add_item("item_seal", 1)
~ unlock_codex("codex_order")
-> DONE

=== печь ===
Печь топится чужими дровами, и я считаю их вслух. Два полена, не спорь.
~ fire_rule("rule_act_melt")
-> DONE
