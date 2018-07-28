<?php

/*
 * Russian 
 * 
 */

//Listing
$_['module_title']    = 'Единицы измерения продукции (выберите набор)';
$_['heading_title']   = 'Единицы измерения продукции';
$_['column_template'] = 'Название набора';
$_['column_action'] = 'Ред.';


$_['tab_templ'] = 'Данные набора';
$_['tab_unit'] = 'Ед. измерения';
$_['tab_base'] = 'Базы расчета';
$_['tab_strings'] = 'Строки упаковок';

//Entries
$_['entry_name'] = 'Название набора единиц измерений';
$_['entry_description'] = 'Описание (для администратора)';
$_['entry_priceBase'] = 'Базовая единица для цен, прайса';
$_['entry_saleBase'] = 'Базовая единица отпуска (кратность)';
$_['entry_packageBase'] = 'Базовая единица загрузки (калькулятор)';
$_['entry_nopartial'] = 'Не делится';

//Columns
$_['column_common'] = 'Основные данные пересчета';
$_['column_name'] = 'Название';
$_['column_name_price'] = '';
$_['column_name_plural'] = 'упаковок';
$_['column_name_package_dimension'] = 'упаковки';
$_['column_strings'] = 'Данные для генерации строк таблицы упаковки';
$_['column_name_in_package'] = 'в упаковке';
$_['column_name_strings'] = 'Словарь';
$_['column_name'] = 'Название';
$_['column_calcKoef'] = 'Содержит';
$_['column_calcKoef_placeholder'] = '0.00000';
$_['column_calcRel'] = 'Что?'; 
$_['column_weight'] = 'Вес, кг<br/> (для расчета норм)';
$_['column_weight_placeholder'] = '0.000';
$_['column_package_strings'] = 'Размеры упаковки:';
$_['column_package_width'] = 'Ширина';
$_['column_package_length'] = 'Длина';
$_['column_package_height'] = 'Толщина';
$_['column_order'] = '№п/п';
$_['column_price_writing'] = '<br/>Написание:';
$_['column_sortOrders'] = 'Порядок отображения. <br/> 0 - для скрытия';
$_['column_switchSortOrder'] = 'переключ. цен';
$_['column_loadingSortOrder'] = 'калькул. загруз.';
$_['column_delete'] = 'Удалить';
$_['column_actions'] = 'Действия';
$_['column_isSaleBase'] = 'База отпуска (кратность)';
$_['column_isPriceBase'] = 'База цен';
$_['column_isPackageBase'] = 'База загрузки (калькулятор)';

//Strings columns
$_['column_strdescription'] = 'Наименование';
$_['column_strvalue'] = 'Значение';
$_['column_strSortOrder'] = '№п/п';

// Help
$_['help_name_price'] = 'Имя отображаемое в переключателе цен карточки продукта';
$_['help_name_plural'] = 'Имя отображаемое в шапке калькулятора и для генерации нек. строк таблицы упаковок (род. падеж множ. числа: рулонов, килограммов, баллонов итд.';
$_['help_name_package_dimension'] = 'Имя для генерации нек. строк таблицы упаковок для размеров и веса (род. падеж ед. числа: [Вес] Рулона, [Размер] Паллеты итд.) ';
$_['help_name_in_package'] = 'Имя для генерации нек. строк таблицы упаковок по шаблону: в упаковке, на паллете итд (с предлогом)';

// Errors
$_['error_name'] = 'Поле обязательно для заполнения. До 100 символов длиной';
$_['error_calcKoef'] = 'Число! целое или дробное > 0';
$_['error_weight'] = 'Число! целое или дробное > 0';
$_['error_isPackageBase'] = 'Обязательное, т.к. база!';
$_['error_package_strings'] = 'Не более 50 симв. любое поле!'; 
$_['error_name_strings'] = 'Не более 50 симв. любое поле!'; 
$_['error_name_price'] = 'Не более 50 симв.';
$_['error_warning_bases'] = 'После создания единиц измерения, не забудьте установить все базы (для цен, для отпуска(кратность) и калькулятора загрузки).';
$_['error_sortOrder'] = 'Число >=0 !';
$_['error_change_package_base'] = 'Выбранная единица измерения не может быть установлена как база загрузки,тк для нее отсутствует вес';


//Action

 // Heading
$_['tab_package'] = 'Строки упаковки';

$_['lists_title'] = 'Список единиц измерений';
$_['form_title'] = 'Форма редактирования';
$_['form_title_edit'] = 'Редактирование ед. изм.';
$_['form_title_add'] = 'Добавление ед. изм.';

// Text
$_['text_module']      = 'Модули';
$_['text_success']     = 'Настройки модуля "Единицы измерения" обновлены!';
$_['text_add_error']     = 'Ошибка бд при создании ед. измерения';
$_['text_edit_error']     = 'Ошибка бд при редактировании ед. измерения';
$_['placeholder']      = 'Вы успешно создали ед. измерения';
$_['entry_filter_category'] = 'Фильтр по категории';
$_['button_filter'] = 'Фильтровать';
$_['button_cancel'] = 'Уровень выше';


$_['column_showInSwitch'] = 'Переключ.'; 
$_['column_isPrice'] = 'Прайс?';
$_['column_isPackage'] = 'Упаковка?';



$_['yes'] = '<i class="fa fa-plus"></i>';
$_['no'] = '<i class="fa fa-minus"></i>';

// Form
$_['entry_calcKoefVerb'] = 'Содержит';
$_['entry_calcKoef'] = 'Коэфф';
$_['entry_produnit_rel'] = 'В еденицу измерения:'; 
$_['entry_switchSortOrder'] = '№п/п в переключателе цен';
$_['entry_showInSwitch'] = 'Показана в переключателе цен карточки товара?'; 
$_['entry_isPrice'] = 'Используется как основная для прайса, корзины, цен?';
$_['entry_isPackage'] = 'Генерировать для ед. изм. строки упаковки?';
$_['entry_package_weight'] = 'Вес упаковки';
$_['entry_package_name'] = 'Название упаковки (для таблицы упаковок)';
$_['entry_package_width'] = 'Ширина упаковки';
$_['entry_package_length'] = 'Длина упаковки';
$_['entry_package_height'] = 'Высота/Толщина упаковки';

// Error
$_['error_permission'] = 'Ошибка: У Вас нет прав на изменение настроек модуля "Свойства продукции"!';
$_['error_default'] = 'Поле "значение по умолчанию" обязательно для заполнения';
$_['error_warning'] = 'Проверьте форму на ошибки';
