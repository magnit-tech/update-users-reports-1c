// @strict-types

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	СейОбъект = РеквизитФормыВЗначение("Объект");
	СейОбъект.Инициализировать(, УникальныйИдентификатор);
	ЗначениеВРеквизитФормы(СейОбъект, "Объект");
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ЗаполнитьНастройкиИзФайлаПриОткрытииАсинх();
	
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	
	Настройки.Вставить("НастройкиОтбора", Объект.КомпоновщикНастроек.ПользовательскиеНастройки);

КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	НастройкиОтбора = Настройки.Получить("НастройкиОтбора");
	Если ТипЗнч(НастройкиОтбора) = Тип("ПользовательскиеНастройкиКомпоновкиДанных") Тогда
		Объект.КомпоновщикНастроек.ЗагрузитьПользовательскиеНастройки(НастройкиОтбора);
	КонецЕсли;
	
	ЗаполнитьВариантыОтчетовНаСервере();

КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)

	Если Модифицированность Тогда
		
		Отказ = Истина;
		Если ЗавершениеРаботы Тогда
			ТекстПредупреждения = "При закрытии формы изменения настроек будет утеряно. Продолжить?";
		Иначе
			СохранитьНастройкиИЗакрытьАсинх();
		КонецЕсли;
		
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ИмяФайлаНастроекНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПоказатьВыборФайлаАсинх();
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаНастроекПриИзменении(Элемент)
	
	ЗаполнитьНастройкиИзФайлаБезОжиданияАсинх();

КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаНастроекОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОткрытьФайлНастроекАсинх();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыОбновляемыеВарианты

&НаКлиенте
Процедура ОбновляемыеВариантыВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	//@skip-check property-return-type - баг ЕДТ
	ПоказатьЗначение(, Элементы.ОбновляемыеВарианты.ТекущиеДанные.ВариантОтчета);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЗаменяемыеПоля

&НаКлиенте
Процедура ЗаменяемыеПоляПриИзменении(Элемент)
	
	Модифицированность = Истина;
	ОбработатьИзменениеНастроек();

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыКомпоновщикНастроекПользовательскиеНастройки

&НаКлиенте
Процедура КомпоновщикНастроекПользовательскиеНастройкиПриИзменении(Элемент)
	
	СохраняемыеВНастройкахДанныеМодифицированы = Истина;
	ЗаполнитьВариантыОтчетов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Команда_СохранитьВФайл(Команда)
	
	СохранитьНастройкиВФайлАсинх();

КонецПроцедуры

&НаКлиенте
Процедура Команда_ЗаполнитьВариантыОтчетов(Команда)
	
	ЗаполнитьВариантыОтчетов();

КонецПроцедуры

&НаКлиенте
Процедура Команда_СброситьНастройкиОтборов(Команда)
	
	СброситьНастройкиОтборов();
	
КонецПроцедуры

&НаКлиенте
Процедура Команда_ОбновитьВариантыОтчетов(Команда)
	
	ОбновитьВариантыОтчетовАсинх();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область НастройкиОбновления

&НаКлиенте
Асинх Процедура ПоказатьВыборФайлаАсинх()
	
	Если Ждать ВыбратьИмяФайлаНастроекАсинх(РежимДиалогаВыбораФайла.Открытие) Тогда
		ЗаполнитьНастройкиИзФайлаБезОжиданияАсинх();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ОткрытьФайлНастроекАсинх()
	
	УказанФайл = Ждать УказанФайлНастроекАсинх();
	Если УказанФайл Тогда
		ЗапуститьПриложение(ИмяФайлаНастроек);
	КонецЕсли;
	
КонецПроцедуры

// Выбрать имя файла настроек.
// 
// Возвращаемое значение:
//  Булево
&НаКлиенте
Асинх Функция ВыбратьИмяФайлаНастроекАсинх(РежимДиалога)
	
	ДиалогВыбораФайла = Новый ДиалогВыбораФайла(РежимДиалога);
	ДиалогВыбораФайла.ПолноеИмяФайла = ИмяФайлаНастроек;
	ДиалогВыбораФайла.МножественныйВыбор = Ложь;
	ДиалогВыбораФайла.Фильтр = "JSON (*.json)|*.json";
	Результат = Ждать ДиалогВыбораФайла.ВыбратьАсинх();
	Если ЗначениеЗаполнено(Результат) Тогда
		ИмяФайлаНастроек = Результат[0];
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Асинх Процедура ЗаполнитьНастройкиИзФайлаПриОткрытииАсинх()
	
	Если Ждать ЗаполнитьНастройкиИзФайлаАсинх() Тогда
		ЗаполнитьВариантыОтчетов();
		ОбработатьИзменениеНастроек();
	КонецЕсли;
	
КонецПроцедуры

// Применить настройки переопределения.
&НаКлиенте
Асинх Процедура ЗаполнитьНастройкиИзФайлаБезОжиданияАсинх()
	
	Если НЕ Ждать ЗаполнитьНастройкиИзФайлаАсинх() Тогда
		ВызватьИсключение "Не удалось заполнить настройки из файла";
	КонецЕсли;
	
КонецПроцедуры

// Применить настройки переопределения.
&НаКлиенте
Асинх Функция ЗаполнитьНастройкиИзФайлаАсинх()
	
	Объект.ЗаменяемыеПоля.Очистить();
	
	ФайлНастроек = Ждать ФайлНастроекАсинх();
	Если ФайлНастроек <> Неопределено Тогда
		ЗаполнитьНастройкиИзФайлаНаСервере(ФайлНастроек);
	КонецЕсли;
	
	ОбработатьИзменениеНастроек();
	
	Модифицированность = Ложь;
	
	Возврат Истина; //Особенность платформы. Процедуры нельзя Ждать
	
КонецФункции

// Файл настроек.
// 
// Возвращаемое значение:
//  ДвоичныеДанные, Неопределено -
&НаКлиенте
Асинх Функция ФайлНастроекАсинх()
	
	ФайлУказан = Ждать УказанФайлНастроекАсинх();
	Если ФайлУказан Тогда
		Возврат Новый ДвоичныеДанные(ИмяФайлаНастроек);
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Указан файл настроек.
// 
// Возвращаемое значение:
//  Булево
&НаКлиенте
Асинх Функция УказанФайлНастроекАсинх()
	
	Если ЗначениеЗаполнено(ИмяФайлаНастроек) Тогда
		Файл = Новый Файл(ИмяФайлаНастроек);
		ФайлСуществует = Ждать Файл.СуществуетАсинх();
		Если ФайлСуществует И Файл.ЭтоФайл() Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Заполнить настройки из файла.
// 
// Параметры:
//  ФайлНастроек - ДвоичныеДанные
&НаСервере
Процедура ЗаполнитьНастройкиИзФайлаНаСервере(ФайлНастроек)

	ИмяВременногоФайла = ПолучитьИмяВременногоФайла("json");
	ФайлНастроек.Записать(ИмяВременногоФайла);
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.ОткрытьФайл(ИмяВременногоФайла);
	НастройкиИзФайла = ПрочитатьJSON(ЧтениеJSON, Ложь);
	ЧтениеJSON.Закрыть();
	
	УдалитьФайлы(ИмяВременногоФайла);
	
	НастройкиОбновления = НовыйНастройкиОбновления();
	ЗаполнитьЗначенияСвойств(НастройкиОбновления, НастройкиИзФайла);
	
	Для Каждого ЗаменяемоеПоле Из НастройкиОбновления.ЗаменяемыеПоля Цикл
		ЗаполнитьЗначенияСвойств(Объект.ЗаменяемыеПоля.Добавить(), ЗаменяемоеПоле);
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура СохранитьНастройкиИЗакрытьАсинх()
	
	Если Модифицированность Тогда
		ФайлСохранен = Ждать СохранитьНастройкиВФайлАсинх("Сохранить изменения настроек в файл?");
		Если НЕ ФайлСохранен Тогда
			Модифицированность = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

// Сохранить настройки в файл.
// 
// Параметры:
//  ТекстВопроса - Строка 
// 
// Возвращаемое значение:
//  Обещание из Булево
&НаКлиенте
Асинх Функция СохранитьНастройкиВФайлАсинх(Знач ТекстВопроса = "")
	
	Если ПустаяСтрока(ТекстВопроса) Тогда
		ТекстВопроса = "Настройки будут записаны в файл
		|Продолжить?";
	КонецЕсли;
	
	Ответ = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет); //КодВозвратаДиалога
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ИмяФайлаНастроек) 
		И НЕ Ждать ВыбратьИмяФайлаНастроекАсинх(РежимДиалогаВыбораФайла.Сохранение) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ТекстовыйДокумент = Новый ТекстовыйДокумент();
	
	НовыйТекст = НастройкиОбновленияДляФайла();
	ТекстовыйДокумент.УстановитьТекст(НовыйТекст);
	ТекстовыйДокумент.Записать(ИмяФайлаНастроек);
	
	Модифицированность = Ложь;
	
	Возврат Истина;
	
КонецФункции

&НаСервере
Функция НастройкиОбновленияДляФайла()
	
	НастройкиОбновления = НовыйНастройкиОбновления();
	НастройкиОбновления.ЗаменяемыеПоля = ОбщегоНазначения.ТаблицаЗначенийВМассив(
		Объект.ЗаменяемыеПоля.Выгрузить());
	
	Возврат НастойкиОбновленияВСтрокуJSON(НастройкиОбновления);
	
КонецФункции

&НаСервере
Функция НастойкиОбновленияВСтрокуJSON(НастройкиОбновления)
	
	ПараметрыЗаписи = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Unix,Символы.Таб); //Читабельное оформление
	
	ЗаписьJSON = Новый ЗаписьJSON;			
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписи);
	ЗаписатьJSON(ЗаписьJSON, НастройкиОбновления);

	Возврат ЗаписьJSON.Закрыть();
	
КонецФункции

// Новый настройки обновления.
// 
// Возвращаемое значение:
//  Структура - Новый настройки обновления:
// * ЗаменяемыеПоля - Массив из Структура
&НаСервереБезКонтекста
Функция НовыйНастройкиОбновления()
	
	Результат = Новый Структура;
	Результат.Вставить("ЗаменяемыеПоля", Новый Массив);
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура СброситьНастройкиОтборов()
	
	СейОбъект = РеквизитФормыВЗначение("Объект");
	СейОбъект.СброситьНастройкиОтборов(,УникальныйИдентификатор);
	ЗначениеВРеквизитФормы(СейОбъект, "Объект");
	
	//Баг платформы. Если не обратиться к коллекции, то изменения на форме не применятся
	//@skip-check module-unused-local-variable
	НовыеПользовательскиеНастройки = СейОбъект.КомпоновщикНастроек.ПользовательскиеНастройки;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьИзменениеНастроек()
	
	ЗаполнитьТекстКодаВызоваОбработки();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТекстКодаВызоваОбработки()
	
	СейОбъект = РеквизитФормыВЗначение("Объект");
	ТекстКодаВызоваОбработки = СейОбъект.ТекстКодаВызоваОбработки();
	
КонецПроцедуры

#КонецОбласти

#Область ОбновлениеВариантов

&НаКлиенте
Процедура ЗаполнитьВариантыОтчетов()
	
	ЗаполнитьВариантыОтчетовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВариантыОтчетовНаСервере()
	
	СейОбъект = РеквизитФормыВЗначение("Объект");
	СейОбъект.ЗаполнитьВариантыОтчетов();
	ЗначениеВРеквизитФормы(СейОбъект, "Объект");
	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ОбновитьВариантыОтчетовАсинх()
	
	ТекстВопроса = "Варианты отчетов будут перезаписаны. Продолжить?";
	Ответ = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет); //КодВозвратаДиалога
	Если Ответ = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	ОбновитьВариантыОтчетовНаСервере();
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВариантыОтчетовНаСервере()
	
	СейОбъект = РеквизитФормыВЗначение("Объект");
	СейОбъект.ОбновитьВариантыОтчетов();
	ЗначениеВРеквизитФормы(СейОбъект, "Объект");
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
