// Микель, потерявшийся путник
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
Он стоит у знака так, будто знак ему должен. Язык уже плохо слушается, и он всё время начинает сначала. # action
Я тут ненадолго, я только посмотрю... тут тропа была, тут, у камня. Она не делась, она просто... # voice: assets/voice/mikael_night.ogg
*   [Сказать правду: ты три часа кружишь на месте] -> правда
*   [Не спорить, развернуть его и вести] -> вести
*   [Отдать ему флягу] -> фляга
-> DONE

=== правда ===
Три часа, вбок и назад, по колено, против ветра. Твой след тоже здесь, только вниз. # emotion: wary
Он молчит, и это первый разумный звук за ночь.
~ change_disposition("npc_mikael", 5)
-> вести

=== вести ===
Идти надо за мной и молчать: на мосту я сам решаю, где верёвка.
*   { get_flag("fire_lit") } [Вести в сторожку к огню] -> сторожка
*   [Вести вверх, к башне] -> наверх
-> DONE
=== сторожка ===
Сенни его пустит: Сенни пускает всех, кто умеет сесть.
~ set_flag("mikael_brought_in")
-> DONE
=== наверх ===
Он посмотрит на башню и решит, что ты сумасшедший. Он прав, но он пойдёт.
~ apply_status("status_exhausted", 6)
-> DONE

=== фляга ===
Отдай воду — и он дойдёт. Оставишь — дойдёте вы оба, но медленнее и злее.
~ remove_item("item_melted_water", 1)
~ change_disposition("npc_mikael", 8)
-> вести
