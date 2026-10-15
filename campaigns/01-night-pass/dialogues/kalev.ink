// Калев, проводник
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

= начало
Он не предлагает помощь, он перекладывает снег с места на место, чтобы стало видно тропу. # action
Ты по знаковому склону шёл? Идти надо не по знакам, а по теням. Я покажу, но я не бегу. # voice: assets/voice/kalev_gully.ogg
*   [Попросить провести к башне коротко] -> коротко
*   [Попросить провести через укрытия] -> длинно
*   [Спросить про карниз] -> карниз
*   [Спросить, сколько ему нужно времени] -> цена
-> DONE

= коротко
Коротко — это через мост: три часа и один пролёт, где держится не настил, а верёвка. Я туда не полезу, там человек нужен один.
~ set_flag("kalev_told_short")
-> цена

= длинно
Через балку, заставу и сторожку: шесть часов, зато с огнём на пути. Если у тебя люди, которых надо вести, — только так.
~ set_flag("kalev_told_long")
-> цена

= карниз
Карниз держит поперёк, если обвязан, и не держит вбок ни с чем. Попроси верёвку у того, кто её не отдаст, и будет тебе коротко.
~ unlock_codex("codex_pass")
-> цена

= цена
Час, чтобы дойти, и час, чтобы довести. Я не считаю в монетах: считай в часах.
*   { get_flag("rope_tied") } [Сказать, что верёвка закреплена] -> с_веревкой
*   [Попросить помочь перевести Талвиса] -> талвис
-> DONE
= с_веревкой
Он смотрит на узел и молча одобрят: редкий для него знак.
~ fire_rule("rule_act_clear")
~ change_disposition("npc_kalev", 8)
-> DONE
= талвис
Того надо не вести, а не давать сесть. Как доведёте до сторожки, я ему растоплю, а ты иди наверх.
~ fire_rule("rule_act_melt")
-> DONE
