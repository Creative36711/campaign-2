// Талвис, потерявшийся путник
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
Он сидит на камне, облепленном снегом, и говорит так ровно, как говорят, когда уже тепло. # action
Я передохну. Честное слово, две минуты, и я встану. Ты же тоже сядешь, правда?
*   [Не давать сесть: поднять и повести] -> поднять
*   [Сесть рядом на две минуты] -> сесть
*   [Объяснить, что через две минуты человек не встаёт] -> объяснить
-> DONE

=== поднять ===
Он тяжелее, чем кажется, и благодарит за это трижды на сотню шагов.
~ fire_rule("rule_act_clear")
~ set_flag("talvis_brought_in")
-> DONE

=== сесть ===
Снег под тобой тает, и это единственная тёплая вещь за ночь. Ты встаёшь первым: повезло, что ты встал.
~ sleep(1)
~ apply_status("status_exhausted", 4)
-> DONE

=== объяснить ===
Он слушает и всё-таки встаёт, потому что ему стало стыдно. Стыд на морозе хорошо греет.
~ change_disposition("npc_talvis", 6)
-> поднять
