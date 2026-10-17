// Рур, дозорный-разведчик
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
Он говорит, не поворачивая головы, и считает ветер по пальцам. # action
Двенадцать секунд, не больше: за это время решают, а не думают. Кто ведёт — тот и виноват, если кто-то сорвётся. # voice: assets/voice/ruur_bridge.ogg
~ set_dialogue_timer(14, "долгий")
*   [Взять двоих на верёвку и идти первым] -> быстрый
*   [Увести всех за опорный камень и ждать порыв] -> долгий
*   [Рубить настил за собой, чтобы зверь не прошёл] -> проход
-> долгий

=== быстрый ===
*   { skill_check("skill_climb", 60) } [Пройти и выбрать путников на тот берег] -> прошли
*   [Сорваться на льду и удержаться на одной руке] -> сорвался
-> DONE
=== прошли ===
Они на том берегу, верёвка держит, зверь остался где-то сзади. Ты потратил ни минуты и семь минут на то, чтобы снова почувствовать пальцы. # emotion: wary
~ set_flag("mikkels_note_left")
~ apply_status("status_exhausted", 6)
-> DONE
=== сорвался ===
Верёвка приняла твой вес и отдала его обратно. Все целы, но ты потерял на это час, а ледяная вода не прощает и часа.
~ sleep(1)
~ apply_status("status_frostbite", 8)
~ set_flag("timer_bridge_slow")
-> DONE

=== долгий ===
Вы ждёте за камнем, пока ветер проходит пролёт, и переходите молча, по одному. Долго, зато никто не висит над обрывом, и это тот вариант, который включается сам, если ты промолчишь.
~ sleep(2)
~ set_flag("timer_bridge_slow")
-> DONE

=== проход ===
Ты рубишь настил у опоры, и пролёт уходит вниз вместе с наледью. Зверь сюда не придёт, но и ты назад не пройдёшь: дорога назад кончилась.
~ set_flag("hound_shaken")
~ clear_flag("hound_close")
~ sleep(1)
-> DONE
