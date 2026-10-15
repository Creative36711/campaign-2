// Олита, возница
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
Она сидит на перевёрнутом полозе и держит ногу так, будто это чужая нога. # action
Не стой надо мной, от тебя тень на снег падает. Ты почтальон? Тогда иди и не оборачивайся. # voice: assets/voice/olita_wreck.ogg
*   [Осмотреть ногу и разорвать рукавицу на перевязку] -> нога
*   [Отдать бурку] -> бурка
*   [Сказать, что дозор выйдет к 06:00] -> дозор
*   [Спросить, что было в ящике] -> ящик
*   [Пойти дальше] -> уход
-> DONE

= нога
*   { skill_check("skill_medicine", 45) } [Перевязать как следует] -> умеешь
*   [Сделать перевязку наспех и идти] -> наспех
= умеешь
Хорошо. Теперь встань и иди сам, я пососу и догоню. В сторожке Сенни, знаешь.
~ set_flag("olita_injured")
~ change_disposition("npc_olita", 10)
-> дозор
= наспех
Криво, но не сползает. Ты потерял на это четверть часа и выиграл то, что она ещё дышит ровно.
~ set_flag("olita_injured")
-> уход

= бурка
Она не благодарит и не отказывается, что честнее любого спасибо. # action
~ fire_rule("rule_give_cloak")
~ set_flag("olita_warm")
Теперь иди, а я полежу до темна, потом поползу.
-> уход

= дозор
Значит, дозор придёт, если его позвать. Свет на башне — он же для этого?
*   [Сказать, что дойдёшь до башни] -> обещание
*   [Сказать, что не обещай себе шесть часов] -> честно2
-> DONE
= обещание
Тогда не ври мне про шесть часов. Веди к сторожке, а башня твоя.
~ set_flag("olita_brought_in")
-> уход
= честно2
Она кивает: правда ей подходит больше, чем бодрый тон.
~ change_disposition("npc_olita", 5)
-> уход

= ящик
Паёк, хворост, верёвка и уздечка, которую я не успела снять. Бери верёвку: без неё на карнизе ты просто вес.
~ add_item("item_rope", 1)
-> уход

= уход
Иди. Я тут не замёрзну насмерть, у меня на это планов нет.
-> DONE
