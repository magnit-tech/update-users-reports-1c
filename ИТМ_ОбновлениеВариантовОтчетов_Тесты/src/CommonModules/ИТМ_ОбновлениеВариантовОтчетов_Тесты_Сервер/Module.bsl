
#Область СлужебныйПрограммныйИнтерфейс

Процедура ИсполняемыеСценарии() Экспорт
    
    Перем ЮТТесты;
    ЮТТесты = ЮТТесты();
    
    ЮТТесты
        .ДобавитьТестовыйНабор("Настройка")
    		.ДобавитьТест("Тест_ОбработкаСоздана")
    		.ДобавитьТест("Тест_ОбработкаИнициализируется")
    		.ДобавитьТест("Тест_НовоеЗаменяемоеПоле")
    		.ДобавитьТест("Тест_НовыйОбновляемыйВариант")
    		.ДобавитьТест("Тест_СброситьНастройкиОтборов")
    	.ДобавитьТестовыйНабор("ОбработатьНастройкиОтчета")
    		.ДобавитьТест("Тест_ОбработатьНастройкиКомпоновки")
    	.ДобавитьТестовыйНабор("ОбработатьЭлементНастроек").Перед("ПередНабором_ОбработатьЭлементНастроек")
    		.ДобавитьТест("Тест_ОбработатьНастройки_ЭлементОтбора")
    			.СПараметрами(Истина, Ложь)
    			.СПараметрами(Ложь, Истина)
    			.СПараметрами(Истина, Истина)
    		.ДобавитьТест("Тест_ОбработатьНастройки_ТипСоСвойством")
    			.СПараметрами("ВыбранноеПолеКомпоновкиДанных", "Поле", Истина)
    			.СПараметрами("ВыбранноеПолеКомпоновкиДанных", "Поле", Ложь)
    			.СПараметрами("ЭлементПорядкаКомпоновкиДанных", "Поле", Истина)
    			.СПараметрами("ЭлементПорядкаКомпоновкиДанных", "Поле", Ложь)
    			.СПараметрами("ОформляемоеПолеКомпоновкиДанных", "Поле", Истина)
    			.СПараметрами("ОформляемоеПолеКомпоновкиДанных", "Поле", Ложь)
    			.СПараметрами("ПолеГруппировкиКомпоновкиДанных", "Поле", Истина)
    			.СПараметрами("ПолеГруппировкиКомпоновкиДанных", "Поле", Ложь)
    			.СПараметрами("ВариантПользовательскогоПоляВыборКомпоновкиДанных", "Значение", Истина)
    			.СПараметрами("ВариантПользовательскогоПоляВыборКомпоновкиДанных", "Значение", Ложь)
    			.СПараметрами("ЗначениеПараметраКомпоновкиДанных", "Значение", Истина)
    			.СПараметрами("ЗначениеПараметраКомпоновкиДанных", "Значение", Ложь)
    			.СПараметрами("ЗначениеПараметраНастроекКомпоновкиДанных", "Значение", Истина)
    			.СПараметрами("ЗначениеПараметраНастроекКомпоновкиДанных", "Значение", Ложь)
    	.ДобавитьТестовыйНабор("ЗаполнитьОбновитьВариантыОтчетов")
	    	.ДобавитьТест("Тест_ЗаполнитьВариантыОтчетов").ВТранзакции()
    		.ДобавитьТест("Тест_ОбновитьВариантыОтчетов").ВТранзакции()
    		.ДобавитьТест("Тест_ОбновитьВариантыОтчетовИзСгенерированногоКода").ВТранзакции()
    	.ДобавитьТест("Тест_НовыйПутьПоляКомпоновки")
    			//Параметры:  ТекущийПуть, ПутьДо, ПутьПосле, НовыйПуть
    			.СПараметрами("Ссылка", "СсыЛка", "Поле", "Поле")
    			.СПараметрами("Ссылка.Реквизит", "СсыЛка", "Поле", "Поле.Реквизит")
    			.СПараметрами("Ссылка.Реквизит.Реквизит2", "СсыЛка", "Поле", "Поле.Реквизит.Реквизит2")
    			.СПараметрами("Ссылка", "Ссылка1", "Поле", "")
    			.СПараметрами("Ссылка1", "Ссылка", "Поле", "")
    	;

КонецПроцедуры

Процедура ПередВсемиТестами() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ОтчетПример = Отчеты.ИТМ_ОбновлениеВариантовОтчетов_Тесты_Отчет.Создать();
	СхемаДо = ОтчетПример.ПолучитьМакет("СхемаДо");
	СхемаПосле = ОтчетПример.ПолучитьМакет("СхемаПосле");
	
	ПримерОбработка = НоваяОбработка();
	ПримерОбработка.Инициализировать();
	ПоляНабораДо = СхемаДо.НаборыДанных.Получить(0).Поля;
	ПоляНабораПосле = СхемаПосле.НаборыДанных.Получить(0).Поля;
	Для ИндексПоля = 0 По ПоляНабораДо.Количество() - 1 Цикл
		ПутьПоляДо = ПоляНабораДо.Получить(ИндексПоля).ПутьКДанным;
		ПутьПоляПосле = ПоляНабораПосле.Получить(ИндексПоля).ПутьКДанным;
		ПримерОбработка.НовоеЗаменяемоеПоле(ПутьПоляДо, ПутьПоляПосле);
	КонецЦикла;
	
	Контекст = ЮТест.КонтекстМодуля();
	Контекст.Вставить("ПримерОбработка", ПримерОбработка);
	Контекст.Вставить("ПримерНастройкиДо", СхемаДо.НастройкиПоУмолчанию);
	Контекст.Вставить("ПримерНастройкиПосле", СхемаПосле.НастройкиПоУмолчанию);
	
КонецПроцедуры

#Область Набор_Настройка

Процедура Тест_ОбработкаСоздана() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = НоваяОбработка();
	ЮТест.ОжидаетЧто(Обработка).ЭтоНеНеопределено();
	
	//Баг платформы. Нельзя сравнить с типом напрямую
	СравнениеЗначений = Новый СравнениеЗначений();
	НужныйТип = СравнениеЗначений.Сравнить(
		ТипЗнч(Обработка), Тип("ВнешняяОбработкаОбъект." + ИмяОбработки()));
		
	ЮТест.ОжидаетЧто(НужныйТип).Равно(0);

КонецПроцедуры

Процедура Тест_ОбработкаИнициализируется() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать();
	
	ЮТест.ОжидаетЧто(Обработка)
		.Свойство("АдресСхемыКомпоновки").Заполнено()
		.Свойство("КомпоновщикНастроек.Настройки.ДоступныеПоляВыбора").Заполнено()
		;

КонецПроцедуры

Процедура Тест_НовоеЗаменяемоеПоле() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать();
	
	ПутьДо = ЮТест.Данные().СлучайнаяСтрока();
	ПустьПосле = ЮТест.Данные().СлучайнаяСтрока();
	Результат = Обработка.НовоеЗаменяемоеПоле(ПутьДо, ПустьПосле);
	
	ЮТест
		.ОжидаетЧто(Обработка)
			.Свойство("ЗаменяемыеПоля").ИмеетДлину(1)
		.Что(Обработка.ЗаменяемыеПоля[0])
			.Равно(Результат)
			.Свойство("Заменять").ЭтоИстина()
			.Свойство("ПутьДо").Равно(ПутьДо)
			.Свойство("ПутьПосле").Равно(ПустьПосле)
		;

КонецПроцедуры

Процедура Тест_НовыйОбновляемыйВариант() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать();
	
	Выборка = Справочники.ВариантыОтчетов.Выбрать();
	Выборка.Следующий();
	ВариантОтчета = Выборка.Ссылка;
	
	Результат = Обработка.НовыйОбновляемыйВариант(ВариантОтчета);
	
	ЮТест
		.ОжидаетЧто(Обработка)
			.Свойство("ОбновляемыеВарианты").ИмеетДлину(1)
		.Что(Обработка.ОбновляемыеВарианты[0])
			.Равно(Результат)
			.Свойство("ВариантОтчета").Равно(ВариантОтчета)
		;

КонецПроцедуры

Процедура Тест_СброситьНастройкиОтборов() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать();
	
	Настройки = Обработка.КомпоновщикНастроек.Настройки; //НастройкиКомпоновкиДанных
	Отборы = Настройки.Отбор.Элементы;
	КоличествоДо = Отборы.Количество();
	
	Отборы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	КоличествоПосле = Отборы.Количество();
	
	АдресСхемыКомпоновкиДо = Обработка.АдресСхемыКомпоновки;
	
	Обработка.СброситьНастройкиОтборов();
	
	ЮТест
		.ОжидаетЧто(Обработка)
			.Свойство("АдресСхемыКомпоновки")
				.Заполнено()
				.НеРавно(АдресСхемыКомпоновкиДо)
		.Что(Обработка.КомпоновщикНастроек.Настройки.Отбор.Элементы)
			.ИмеетДлину(КоличествоДо)
			.НеРавно(КоличествоПосле)
		;

КонецПроцедуры

#КонецОбласти

#Область Набор_ОбработатьНастройкиОтчета

Процедура Тест_ОбработатьНастройкиКомпоновки() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Обработка = ПримерОбработка();
	НастройкиДо = ПримерНастройкиДо();
	НастройкиПосле = ПримерНастройкиПосле();
	
	Обработка.ОбработатьНастройкиОтчета(НастройкиДо);
	
	СтрокаНастройкиДо = СтрокаНастроек(НастройкиДо);
	СтрокаНастройкиПосле = СтрокаНастроек(НастройкиПосле);
	
	ЮТест.ОжидаетЧто(СтрокаНастройкиДо).Равно(СтрокаНастройкиПосле);

КонецПроцедуры

#КонецОбласти

#Область Набор_ОбработатьЭлементНастроек

// Контекст набора обработать элемент настроек.
// 
// Возвращаемое значение:
//  Структура - Контекст набора обработать элемент настроек:
// * Обработка - см. НоваяОбработка
// * ЗаменяемыеПоля - Массив из Структура -:
// ** ПолеДо - ПолеКомпоновкиДанных
// ** ПолеПосле - ПолеКомпоновкиДанных
Функция КонтекстНабора_ОбработатьЭлементНастроек() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ДанныеКонтекста = Новый Структура(); //см. КонтекстНабора_ОбработатьЭлементНастроек
	
	ИмяСвойстваКонтекста = "Параметры";
	КонтекстНабора = ЮТест.КонтекстТестовогоНабора();
	Если КонтекстНабора.Свойство(ИмяСвойстваКонтекста, ДанныеКонтекста) Тогда
		Возврат ДанныеКонтекста;
	КонецЕсли;
	
	Обработка = ПримерОбработка();
	
	ДанныеКонтекста = Новый Структура();
	ДанныеКонтекста.Вставить("Обработка", Обработка);
	ДанныеКонтекста.Вставить("ЗаменяемыеПоля", Новый Массив);
	
	Для Каждого ЗаменяемоеПоле Из Обработка.ЗаменяемыеПоля() Цикл
		
		ПолеДо = Новый ПолеКомпоновкиДанных(ЗаменяемоеПоле.ПутьДо);
		ПолеПосле = Новый ПолеКомпоновкиДанных(ЗаменяемоеПоле.ПутьПосле);
		
		ОписаниеЗамены = Новый Структура("ПолеДо,ПолеПосле", ПолеДо, ПолеПосле);
		ДанныеКонтекста.ЗаменяемыеПоля.Добавить(ОписаниеЗамены);
		
		СлучайнаяСтрока = ЮТест.Данные().СлучайнаяСтрока();
		ПодчиненноеПолеДо = Новый ПолеКомпоновкиДанных(СтрШаблон("%1.%2", ЗаменяемоеПоле.ПутьДо, СлучайнаяСтрока));
		ПодчиненноеПолеПосле = Новый ПолеКомпоновкиДанных(СтрШаблон("%1.%2", ЗаменяемоеПоле.ПутьПосле, СлучайнаяСтрока));
		
		ОписаниеЗамены = Новый Структура("ПолеДо,ПолеПосле", ПолеДо, ПолеПосле);
		ДанныеКонтекста.ЗаменяемыеПоля.Добавить(ОписаниеЗамены);
		
	КонецЦикла;
	
	КонтекстНабора.Вставить(ИмяСвойстваКонтекста, ДанныеКонтекста);
	
	Возврат ДанныеКонтекста;
	
КонецФункции

Процедура ПередНабором_ОбработатьЭлементНастроек() Экспорт
	
	КонтекстНабора_ОбработатьЭлементНастроек();
	
КонецПроцедуры

Процедура Тест_ОбработатьНастройки_ЭлементОтбора(ПроверитьЛевое, ПроверитьПравое) Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Контекст = КонтекстНабора_ОбработатьЭлементНастроек();
	
	СлучайноеЗначение = Новый УникальныйИдентификатор();
	
	Для Каждого ЗаменяемоеПоле Из Контекст.ЗаменяемыеПоля Цикл
		
		ЭлементОтбора = НовыйОбъект("ЭлементОтбораКомпоновкиДанных"); //ЭлементОтбораКомпоновкиДанных
		ЭлементОтбора.ЛевоеЗначение = ?(ПроверитьЛевое, ЗаменяемоеПоле.ПолеДо, СлучайноеЗначение);
		ЭлементОтбора.ПравоеЗначение = ?(ПроверитьПравое, ЗаменяемоеПоле.ПолеДо, СлучайноеЗначение);
		
		Контекст.Обработка.ОбработатьНастройкиОтчета(ЭлементОтбора);
		
		ЮТест
			.ОжидаетЧто(ЭлементОтбора)
				.Свойство("ЛевоеЗначение").Равно(?(ПроверитьЛевое, ЗаменяемоеПоле.ПолеПосле, СлучайноеЗначение))
				.Свойство("ПравоеЗначение").Равно(?(ПроверитьПравое, ЗаменяемоеПоле.ПолеПосле, СлучайноеЗначение))
			;
		
	КонецЦикла;
		
КонецПроцедуры

Процедура Тест_ОбработатьНастройки_ТипСоСвойством(ИмяТипа, ИмяСвойства, Заменить) Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Контекст = КонтекстНабора_ОбработатьЭлементНастроек();
	
	СлучайноеПоле = Новый ПолеКомпоновкиДанных(ЮТест.Данные().СлучайнаяСтрока());
	
	Для Каждого ЗаменяемоеПоле Из Контекст.ЗаменяемыеПоля Цикл
	
		Если Заменить Тогда
			ЗначениеДо = ЗаменяемоеПоле.ПолеДо;
			ЗначениеПосле = ЗаменяемоеПоле.ПолеПосле;
		Иначе
			ЗначениеДо = СлучайноеПоле;
			ЗначениеПосле = ЗначениеДо;
		КонецЕсли;
		
		ЭлементНастроек = НовыйОбъект(ИмяТипа);
		ЭлементНастроек[ИмяСвойства] = ЗначениеДо;
		
		Контекст.Обработка.ОбработатьНастройкиОтчета(ЭлементНастроек);
		ЮТест.ОжидаетЧто(ЭлементНастроек).Свойство(ИмяСвойства).Равно(ЗначениеПосле);
	
	КонецЦикла;
		
КонецПроцедуры

#КонецОбласти

#Область Набор_ЗаполнитьОбновитьВариантыОтчетов

Процедура Тест_ЗаполнитьВариантыОтчетов() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ТестовыеДанные = ТестовыеДанные_ЗаполнитьОбновитьВариантыОтчетов();
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать(ТестовыеДанные.Отчет);
	Обработка.ЗаполнитьВариантыОтчетов();
	
	ЮТест
		.ОжидаетЧто(Обработка.ОбновляемыеВарианты)
			.ИмеетДлину(1)
			.Свойство("[0].ВариантОтчета").Равно(ТестовыеДанные.Вариант)
	;
	
КонецПроцедуры

Процедура Тест_ОбновитьВариантыОтчетов() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ТестовыеДанные = ТестовыеДанные_ЗаполнитьОбновитьВариантыОтчетов();
	
	СтрокаНастройки = СтрокаНастроек(ТестовыеДанные.Вариант.Настройки);
	СтрокаНастройкиЭталон = СтрокаНастроек(ТестовыеДанные.НастройкиДо);
	ЮТест.ОжидаетЧто(СтрокаНастройки, "В варианте корректные настройки ДО изменений").Равно(СтрокаНастройкиЭталон);
	
	Обработка = НоваяОбработка();
	Обработка.Инициализировать(ТестовыеДанные.Отчет);
	Обработка.ЗаменяемыеПоля.Загрузить(
		ТестовыеДанные.Обработка.ЗаменяемыеПоля.Выгрузить());
	
	Обработка.ЗаполнитьВариантыОтчетов();
	Обработка.ОбновитьВариантыОтчетов();
	
	ОбновляемыеВарианты = Обработка.ОбновляемыеВарианты;
	ЮТест.ОжидаетЧто(ОбновляемыеВарианты.Количество(), "Найден один обновляемый вариант").Равно(1);
	ЮТест.ОжидаетЧто(ОбновляемыеВарианты[0].Изменен, "Обновляемый вариант изменен").Равно(Истина);
	
	СтрокаНастройки = СтрокаНастроек(ТестовыеДанные.Вариант.Настройки);
	СтрокаНастройкиЭталон = СтрокаНастроек(ТестовыеДанные.НастройкиПосле);
	ЮТест.ОжидаетЧто(СтрокаНастройки, "В варианте корректные настройки ПОСЛЕ изменений").Равно(СтрокаНастройкиЭталон);
	
	Обработка.ОбновитьВариантыОтчетов();
	ЮТест.ОжидаетЧто(ОбновляемыеВарианты[0].Изменен, "Обновляемый вариант не изменен повторно").Равно(Ложь);
	
КонецПроцедуры

Процедура Тест_ОбновитьВариантыОтчетовИзСгенерированногоКода() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ТестовыеДанные = ТестовыеДанные_ЗаполнитьОбновитьВариантыОтчетов();
	
	//Проверим, что в варианте настройки ДО изменений
	СтрокаНастройки = СтрокаНастроек(ТестовыеДанные.Вариант.Настройки);
	СтрокаНастройкиЭталон = СтрокаНастроек(ТестовыеДанные.НастройкиДо);
	
	ЮТест.ОжидаетЧто(СтрокаНастройки).Равно(СтрокаНастройкиЭталон);
	
	ТекстОбработки = ТестовыеДанные.Обработка.ТекстКодаВызоваОбработки();
	
	//Заменим создание внутренней обработки на внешнюю
	ИмяТестируемойОбработки = ИмяОбработки();
	ТекстСозданияОбработки = СтрШаблон("Обработки.%1.Создать()", ИмяТестируемойОбработки);
	ТекстСозданияВнешнейОбработки = СтрШаблон("ВнешниеОбработки.Создать(""%1"")", ИмяТестируемойОбработки);
	ТекстОбработки = СтрЗаменить(ТекстОбработки, ТекстСозданияОбработки, ТекстСозданияВнешнейОбработки);
	
	//Заменим создание внутренней обработки на внешнюю
	ИмяТестируемойОбработки = ИмяОбработки();
	ТекстСозданияОбработки = СтрШаблон("Обработки.%1.Создать()", ИмяТестируемойОбработки);
	ТекстСозданияВнешнейОбработки = СтрШаблон("ВнешниеОбработки.Создать(""%1"")", ИмяТестируемойОбработки);
	ТекстОбработки = СтрЗаменить(ТекстОбработки, ТекстСозданияОбработки, ТекстСозданияВнешнейОбработки);
	
	ТекстШаблонаМетаданныхОтчета = "Метаданные.Отчеты.<ИмяОтчета>";
	ТекстМетаданныхТекущегоОтчета = СтрЗаменить(ТекстШаблонаМетаданныхОтчета, "<ИмяОтчета>", ТестовыеДанные.Отчет.Имя);
	ТекстОбработки = СтрЗаменить(ТекстОбработки, ТекстШаблонаМетаданныхОтчета, ТекстМетаданныхТекущегоОтчета);
	
	//Выполним сгенерированный код
	Выполнить(ТекстОбработки);
	
	//Проверим, что в варианте настройки ПОСЛЕ изменений
	СтрокаНастройки = СтрокаНастроек(ТестовыеДанные.Вариант.Настройки);
	СтрокаНастройкиЭталон = СтрокаНастроек(ТестовыеДанные.НастройкиПосле);
	
	ЮТест.ОжидаетЧто(СтрокаНастройки).Равно(СтрокаНастройкиЭталон);
	
КонецПроцедуры

#КонецОбласти

#Область Набор_НовыйПутьПоляКомпоновки

// Контекст набора НовыйПутьПоляКомпоновки.
// 
// Возвращаемое значение:
//  Структура - :
// * Обработка - см. НоваяОбработка
Функция КонтекстНабора_НовыйПутьПоляКомпоновки() Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	ДанныеКонтекста = Новый Структура(); //см. КонтекстНабора_НовыйПутьПоляКомпоновки
	
	ИмяСвойстваКонтекста = "Параметры";
	КонтекстНабора = ЮТест.КонтекстТестовогоНабора();
	Если КонтекстНабора.Свойство(ИмяСвойстваКонтекста, ДанныеКонтекста) Тогда
		Возврат ДанныеКонтекста;
	КонецЕсли;
	
	Обработка = ПримерОбработка();
	
	ДанныеКонтекста = Новый Структура();
	ДанныеКонтекста.Вставить("Обработка", Обработка);
	
	КонтекстНабора.Вставить(ИмяСвойстваКонтекста, ДанныеКонтекста);
	
	Возврат ДанныеКонтекста;
	
КонецФункции

Процедура Тест_НовыйПутьПоляКомпоновки(ТекущийПуть, ПутьДо, ПутьПосле, НовыйПуть) Экспорт
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	Контекст = КонтекстНабора_НовыйПутьПоляКомпоновки();
	Результат = Контекст.Обработка.НовыйПутьПоляКомпоновки(ТекущийПуть, ПутьДо, ПутьПосле);
	
	ЮТест.ОжидаетЧто(Результат).Равно(НовыйПуть);
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ТестовыйДвижок

// ЮТТесты
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция ЮТТесты()
	
	Возврат ОбщийМодуль("ЮТТесты")
	
КонецФункции

// ЮТТест
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция ЮТест()
	
	Возврат ОбщийМодуль("ЮТест")
	
КонецФункции

#КонецОбласти

#Область ТестируемаяОбработка

// Обработка.
// 
// Возвращаемое значение:
//  см. ИнтерфейсОбработки
Функция НоваяОбработка()
	
	Возврат ВнешниеОбработки.Создать(ИмяОбработки());
	
КонецФункции

// Имя обработки.
// 
// Возвращаемое значение:
//  Строка
Функция ИмяОбработки()
	
	Возврат "ИТМ_ОбновлениеВариантовОтчетов";
	
КонецФункции

#КонецОбласти

#Область ТестовыеДанные

// Обработка.
// 
// Возвращаемое значение:
//  см. ИнтерфейсОбработки
Функция ПримерОбработка()
	
	Возврат ЮТест().КонтекстМодуля().ПримерОбработка;
	
КонецФункции

// Пример настроек ДО изменений полей
// 
// Параметры:
//  Копия - Булево
// 
// Возвращаемое значение:
//  НастройкиКомпоновкиДанных
Функция ПримерНастройкиДо(Копия = Истина)
	
	Возврат ЗначениеИзКонтекстаМодуля("ПримерНастройкиДо", Копия);
	
КонецФункции

// Пример настроек ПОСЛЕ изменений полей (эталонный результат)
// 
// Параметры:
//  Копия - Булево
// 
// Возвращаемое значение:
//  НастройкиКомпоновкиДанных
Функция ПримерНастройкиПосле(Копия = Ложь)
	
	Возврат ЗначениеИзКонтекстаМодуля("ПримерНастройкиПосле", Копия);
	
КонецФункции

// ИЗМЕНЯЕТ БД! Тестовые данные набора заполнить\обновить варианты отчетов.
// 
// Возвращаемое значение:
//  Структура - :
// * Обработка - см. НовыйОбъект
// * Отчет - СправочникСсылка.ИдентификаторыОбъектовРасширений
// * Вариант - СправочникСсылка.ВариантыОтчетов
// * НастройкиПосле - НастройкиКомпоновкиДанных
Функция ТестовыеДанные_ЗаполнитьОбновитьВариантыОтчетов()
	
	Перем ЮТест;
	ЮТест = ЮТест();
	
	НастройкиКомпоновкиДо = ПримерНастройкиДо();
	
	МетаданныеТестовогоОтчета = Метаданные.Отчеты.ИТМ_ОбновлениеВариантовОтчетов_Тесты_Отчет;
	
	ТестовыйОтчет = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(МетаданныеТестовогоОтчета);
	
	РеквизитыТестовогоВарианта = Новый Структура("Отчет,Пользовательский,Настройки", 
		ТестовыйОтчет, Истина, Новый ХранилищеЗначения(НастройкиКомпоновкиДо));
	ТестовыйВариант = ЮТест.Данные().СоздатьЭлемент(
		"Справочник.ВариантыОтчетов", 
		МетаданныеТестовогоОтчета.Имя, 
		РеквизитыТестовогоВарианта,
		Новый Структура("ОбменДаннымиЗагрузка", Истина)); //СправочникСсылка.ВариантыОтчетов
	
	Обработка = ПримерОбработка();
	ДанныеКонтекста = Новый Структура();
	ДанныеКонтекста.Вставить("Обработка", Обработка);
	ДанныеКонтекста.Вставить("Отчет", ТестовыйОтчет);
	ДанныеКонтекста.Вставить("Вариант", ТестовыйВариант); 
	ДанныеКонтекста.Вставить("НастройкиДо", НастройкиКомпоновкиДо);
	ДанныеКонтекста.Вставить("НастройкиПосле", ПримерНастройкиПосле());
	
	//@skip-check constructor-function-return-section - баг ЕДТ
	Возврат ДанныеКонтекста;
	
КонецФункции

Функция ЗначениеИзКонтекстаМодуля(ИмяСвойства, Копия)
	
	Значение = ЮТест().КонтекстМодуля()[ИмяСвойства];
	Если Копия Тогда
		Возврат КопияЗначения(Значение);
	Иначе
		Возврат Значение;
	КонецЕсли;
	
КонецФункции

// Интерфейс обработки.
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ИТМ_ОбновлениеВариантовОтчетов_Интерфейс
Функция ИнтерфейсОбработки()
	
	Возврат Обработки.ИТМ_ОбновлениеВариантовОтчетов_Интерфейс.Создать();
	
КонецФункции

#КонецОбласти

#Область Вспомогательные

// Новый объект.
// 
// Параметры:
//  ИмяТипа - Строка
// 
// Возвращаемое значение:
//  Произвольный
Функция НовыйОбъект(ИмяТипа)
	
	ОписаниеТипов = Новый ОписаниеТипов(ИмяТипа);
	Возврат ОписаниеТипов.ПривестиЗначение();
	
КонецФункции

// Копия значения.
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  Произвольный
Функция КопияЗначения(Значение)
	
	Возврат ЗначениеИзСтрокиВнутр(ЗначениеВСтрокуВнутр(Значение));
	
КонецФункции

// ОбщийМодуль
// 
// Возвращаемое значение:
//  ОбщийМодуль
Функция ОбщийМодуль(Имя)
	
	Возврат Вычислить(Имя);
	
КонецФункции

// Строка настроек.
// 
// Параметры:
//  Настройки - ХранилищеЗначения, НастройкиКомпоновкиДанных, Произвольный -
// 
// Возвращаемое значение:
//  Строка
Функция СтрокаНастроек(Знач Настройки)
	
	Если ТипЗнч(Настройки) = Тип("ХранилищеЗначения") Тогда
		Возврат СтрокаНастроек(Настройки.Получить());
	ИначеЕсли ТипЗнч(Настройки) = Тип("НастройкиКомпоновкиДанных") Тогда
		Возврат ОбщегоНазначения.ЗначениеВСтрокуXML(Настройки);
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецОбласти
