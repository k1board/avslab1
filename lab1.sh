#!/usr/bin/env bash
set -e

# Часть 1: Структура каталогов, файлы и права доступа
mkdir -p claude_monet/kitchen/hot_station claude_monet/kitchen/cold_station claude_monet/hall claude_monet/office locker_room

cat << 'EOC' > claude_monet/kitchen/hot_station/barinov_order
Подготовить горячий цех к вечерней смене
Проверить рабочие места поваров
Макса к плите без разрешения не подпускать
EOC

cat << 'EOC' > claude_monet/kitchen/hot_station/senya_task
Сеня отвечает за мясные блюда
Получить продукты на складе
Перед закрытием проверить остатки
EOC

cat << 'EOC' > claude_monet/kitchen/cold_station/fedya_task
Федя отвечает за рыбные блюда
Проверить свежесть сибаса и дорадо
Подготовить холодные закуски для гостей
EOC
cat << 'EOC' > claude_monet/kitchen/menu_draft
Утиная ножка с овощами
Луковый суп по рецепту шефа
Фирменный десерт от Луи
Новое блюдо Макса отправлено на доработку
EOC

cat << 'EOC' > claude_monet/hall/reservations
Столик 3 забронирован на восемнадцать часов
Столик 7 подготовить для постоянных гостей
Большой стол оставить для вечернего банкета
EOC

cat << 'EOC' > claude_monet/hall/guest_reviews
Гости похвалили десерт и работу официантов
Один гость слишком долго ждал горячее блюдо
Постоянные гости попросили вернуть старое меню
Новый повар Макс показался гостям растерянным
EOC
cat << 'EOC' > claude_monet/office/vika_schedule
Вика проводит собрание перед открытием ресторана
В семнадцать часов проверить готовность зала
После смены принять отчёт от Макса
EOC

cat << 'EOC' > locker_room/max_resume
Максим Лавров приехал в Москву из Воронежа
Хочет стать профессиональным поваром
Готов работать в ресторане Claude Monet
Опыта мало, но желания много
EOC

cat << 'EOC' > locker_room/leva_note
Лёва должен показать Максу рабочее место
Объяснить правила кухни и порядок выдачи блюд
О результате доложить Виктору Петровичу
EOC
cat << 'EOC' > nagiev_message
Владелец ресторана приедет вечером
Подготовить лучший стол в зале
Баринов должен лично представить новое меню
EOC

cat << 'EOC' > first_shift
Макс прибыл в ресторан вовремя
Лёва выдал ему форму
Первая задача получена от шефа
EOC
chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/kitchen
chmod 770 claude_monet/kitchen/hot_station
chmod u=rw,g=r,o= claude_monet/kitchen/hot_station/barinov_order
chmod 640 claude_monet/kitchen/hot_station/senya_task
chmod u=rwx,g=rx,o= claude_monet/kitchen/cold_station
chmod 600 claude_monet/kitchen/cold_station/fedya_task
chmod u=rw,g=r,o=r claude_monet/kitchen/menu_draft
chmod 755 claude_monet/hall
chmod u=rw,g=rw,o=r claude_monet/hall/reservations
chmod 444 claude_monet/hall/guest_reviews
chmod u=rwx,g=x,o= claude_monet/office
chmod 640 claude_monet/office/vika_schedule
chmod u=rwx,g=rx,o= locker_room
chmod 600 locker_room/max_resume
chmod u=r,g=r,o= locker_room/leva_note
chmod 444 nagiev_message
chmod u=rw,g=r,o=r first_shift
# Часть 2: Копирование, перемещение и ссылки
cp locker_room/max_resume claude_monet/office/candidate_max
cp -r claude_monet/hall claude_monet/kitchen/hall_backup
ln -s ../claude_monet/kitchen/menu_draft locker_room/first_menu
ln -s claude_monet/hall guest_zone
ln first_shift claude_monet/kitchen/shift_plan
cat claude_monet/kitchen/hot_station/senya_task claude_monet/kitchen/cold_station/fedya_task > claude_monet/kitchen/team_tasks
cat locker_room/leva_note >> first_shift
mv nagiev_message claude_monet/office/owner_message
# Часть 3: Конвейеры фильтрации
ls -lR ~/lab0 | grep '^-' | sort -k 5,5 -n -r | head -n 5
grep -r -h -i 'макс' ~/lab0 | grep -v 'отчёт' | sort -r | head -n 4
cat claude_monet/kitchen/hot_station/*_task claude_monet/kitchen/cold_station/*_task | grep -i -E 'блюд|продукт' | sort | wc -w
ls -lR ~/lab0 | grep -E '^-[^[:space:]]+[[:space:]]+2[[:space:]]' | sort -k 9,9 -r
(head -q -n 1 claude_monet/kitchen/hot_station/*; tail -q -n 1 claude_monet/kitchen/hot_station/*) | sort
grep -i 'гост' claude_monet/hall/guest_reviews | grep -v -i 'постоянн' | sort -r | head -n 2
grep -r -l -i 'гост' claude_monet/kitchen/hall_backup | wc -l
# Удаление
rm locker_room/max_resume
rm locker_room/first_menu
rm guest_zone
rm first_shift
rm claude_monet/kitchen/shift_plan
rm claude_monet/kitchen/cold_station/fedya_task
rmdir claude_monet/kitchen/cold_station
rm -rf claude_monet/kitchen/hall_backup
