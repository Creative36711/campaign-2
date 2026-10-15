// Саара, старшая из потерявшихся
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
Она держит сестру за руку так, что у самой побелели пальцы, и смотрит на тебя как на прогноз погоды. # action
Не подходи. Скажи слово, и я решу, ты человек или ещё один обещатель. # voice: assets/voice/saara_oldpost.ogg
*   [Сказать, что дозор будет в 06:00 и без света не выйдет] -> дозор
*   [Сказать, что в сторожке Сенни есть огонь] -> огонь
*   [Попросить не идти со мной, а идти первой] -> первая
*   [Спросить про мост] -> мост
-> DONE

=== дозор ===
Значит, ты придёшь к свету, а мы полежим здесь до 06:00, пока ты его не зажжёшь. Умно.
*   [Предложить пойти вместе до сторожки] -> вместе
*   [Сказать, что иначе никто не выйдет] -> честно
-> DONE
=== вместе ===
Она смотрит на Марит, потом на тропу, и решает, что чужая спина лучше своей.
~ change_disposition("npc_saara", 12)
-> первая
=== честно ===
Она кивает: ей проще поверить в твою злость, чем в твою доброту.
~ change_disposition("npc_saara", 4)
-> первая

=== огонь ===
Сенни не пускает чужих. Скажешь ему, что ты меня привёл, и он поверит тебе, а не мне.
~ change_disposition("npc_saara", 6)
-> первая

=== первая ===
Идти первой — значит видеть, куда ступает Марит. Это единственное, что её устраивает.
Она поднимается, не выпуская верёвку из второй руки.
~ set_flag("sisters_brought_in")
-> DONE

=== мост ===
Мост держит на верёвке и на весе, который пошёл поперёк. Всё остальное — наглость, а не техника.
*   [Отдать верёвку] -> отдать
*   [Сказать, что верёвка понадобится тебе] -> оставить
-> DONE
=== отдать ===
Она привязывает конец к поясу Марит и делает вид, что это ничего не значит. Значит.
~ remove_item("item_rope", 1)
~ change_disposition("npc_saara", 14)
~ set_flag("rope_tied")
-> первая
=== оставить ===
Правильный ответ: ты ей не дядя. Но запомни, что ты выбрал верёвку, а не её доверие.
~ change_disposition("npc_saara", -6)
-> огонь
