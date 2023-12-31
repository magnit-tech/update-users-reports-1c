// @strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем СобытиеЖурналаРегистрации; // Строка

#КонецОбласти

#Область ПрограммныйИнтерфейс

#Область Настройка

// Инициализировать.
// 
// Параметры:
//  Отчет - см. Справочник.ВариантыОтчетов.Отчет
//  ИдентификаторФормы - УникальныйИдентификатор
Процедура Инициализировать(Знач Отчет = Неопределено, Знач ИдентификаторФормы = Неопределено) Экспорт

	Инициализировать_Очистка();
	
	СброситьНастройкиОтборов(Отчет, ИдентификаторФормы);
	
КонецПроцедуры

// Сбросить настройки отборов
// 
// Параметры:
//  Отчет - см. Справочник.ВариантыОтчетов.Отчет
//  ИдентификаторФормы - УникальныйИдентификатор
Процедура СброситьНастройкиОтборов(Знач Отчет = Неопределено, Знач ИдентификаторФормы = Неопределено) Экспорт
	
	Инициализировать_Компоновщик(ИдентификаторФормы);
	
	Инициализировать_ОтборОтчета(Отчет);
	
КонецПроцедуры

// Заполнить заменяемые поля.
// 
// Параметры:
//  СтрокаПолей - Строка - Строка с полями ДО и После замены
Процедура ЗаполнитьЗаменяемыеПоля(СтрокаПолей) Экспорт
	
	РазделительПолей = РазделительДляЗаполненияЗаменяемыхПолей();
	КоличествоСтрок = СтрЧислоСтрок(СтрокаПолей);
	Для НомерСтроки = 1 По КоличествоСтрок Цикл
		ТекущаяСтрока = СтрПолучитьСтроку(СтрокаПолей, НомерСтроки);
		Если ЗначениеЗаполнено(ТекущаяСтрока) Тогда
			ТекущиеПоля = СтрРазделить(ТекущаяСтрока, РазделительПолей);
			НовоеЗаменяемоеПоле(ТекущиеПоля[0], ТекущиеПоля[1]);
		КонецЕсли;
	КонецЦикла;

КонецПроцедуры

// Новое заменяемое поле.
// 
// Параметры:
//  ПутьДо - Строка
//  ПутьПосле - Строка
// 
// Возвращаемое значение:
//  ОбработкаТабличнаяЧастьСтрока.ИТМ_ОбновлениеВариантовОтчетов.ЗаменяемыеПоля
Функция НовоеЗаменяемоеПоле(ПутьДо, ПутьПосле) Экспорт
	
	ЗаменяемоеПоле = ЗаменяемыеПоля.Добавить();
	ЗаменяемоеПоле.Заменять = Истина;
	ЗаменяемоеПоле.ПутьДо = СокрЛП(ПутьДо);
	ЗаменяемоеПоле.ПутьПосле = СокрЛП(ПутьПосле);
	
	Возврат ЗаменяемоеПоле;
	
КонецФункции

// Новый обновляемый вариант.
// 
// Параметры:
//  ВариантОтчета - СправочникСсылка.ВариантыОтчетов
// 
// Возвращаемое значение:
//  ОбработкаТабличнаяЧастьСтрока.ИТМ_ОбновлениеВариантовОтчетов.ОбновляемыеВарианты
Функция НовыйОбновляемыйВариант(ВариантОтчета) Экспорт
	
	Строка = ОбновляемыеВарианты.Добавить();
	Строка.ВариантОтчета = ВариантОтчета;
	Возврат Строка;
	
КонецФункции

// Текст кода вызова обработки.
// 
// Возвращаемое значение:
//  Строка
Функция ТекстКодаВызоваОбработки() Экспорт
	
	РазделительПолей = РазделительДляЗаполненияЗаменяемыхПолей();
	
	ЧастиТекста = Новый Массив(); //Массив из Строка
	ЧастиТекста.Добавить(СтрШаблон("Обработка = Обработки.%1.Создать();", Метаданные().Имя));
	ЧастиТекста.Добавить("");
	ЧастиТекста.Добавить("//Инициализация с указанием отчета");
	ЧастиТекста.Добавить("СсылкаНаОтчет = ОбщегоНазначения.ИдентификаторОбъектаМетаданных(Метаданные.Отчеты.<ИмяОтчета>);");
	ЧастиТекста.Добавить("Обработка.Инициализировать(СсылкаНаОтчет);");
	ЧастиТекста.Добавить("");
	ЧастиТекста.Добавить("//Заполнение списка вариантов отчетов. Возможна настройка отборов через Обработка.КомпоновщикНастроек");
	ЧастиТекста.Добавить("Обработка.ЗаполнитьВариантыОтчетов();");
	ЧастиТекста.Добавить("");
	ЧастиТекста.Добавить("//Заменяемые поля");
	ЧастиТекста.Добавить("ЗаменяемыеПоля = """);
	Для Каждого ТекущиеДанные Из ЗаменяемыеПоля() Цикл
		ТекущаяСтрока = "|	%1 %2 %3";
		ТекущаяСтрока = СтрШаблон(ТекущаяСтрока, ТекущиеДанные.ПутьДо, РазделительПолей, ТекущиеДанные.ПутьПосле);
		ЧастиТекста.Добавить(ТекущаяСтрока);
	КонецЦикла;
	ЧастиТекста.Добавить("|"";");
	ЧастиТекста.Добавить("Обработка.ЗаполнитьЗаменяемыеПоля(ЗаменяемыеПоля);");
	ЧастиТекста.Добавить("");
	ЧастиТекста.Добавить("//Обновление вариантов отчетов");
	ЧастиТекста.Добавить("Обработка.ОбновитьВариантыОтчетов();");
	
	Возврат СтрСоединить(ЧастиТекста, Символы.ПС);
	
КонецФункции

#КонецОбласти

#Область Выполнение

// Заполнить варианты отчетов.
Процедура ЗаполнитьВариантыОтчетов() Экспорт
	
	СхемаКомпоновки = ПолучитьИзВременногоХранилища(АдресСхемыКомпоновки); //СхемаКомпоновкиДанных
	КомпоновщикМакета = Новый КомпоновщикМакетаКомпоновкиДанных;     
	МакетКомпоновки = КомпоновщикМакета.Выполнить(СхемаКомпоновки, 
		КомпоновщикНастроек.ПолучитьНастройки(),,,Тип("ГенераторМакетаКомпоновкиДанныхДляКоллекцииЗначений"));
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки);
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	Результат = ПроцессорВывода.Вывести(ПроцессорКомпоновки);
	
	ОбновляемыеВарианты.Загрузить(Результат);
	
КонецПроцедуры

// Обновить варианты отчетов.
Процедура ОбновитьВариантыОтчетов() Экспорт
	
	ПараметрыВыполнения = ПараметрыОбработкиНастроек();
	
	Для Каждого ТекущиеДанные Из ОбновляемыеВарианты Цикл
		
		Если ЗначениеЗаполнено(ТекущиеДанные.ВариантОтчета) Тогда
			
			ТекущиеДанные.Изменен = Ложь;
			
			ТекущийОбъект = ТекущиеДанные.ВариантОтчета.ПолучитьОбъект();
			НастройкиОтчета = ТекущийОбъект.Настройки.Получить(); //НастройкиКомпоновкиДанных
			Если НЕ ТипЗнч(НастройкиОтчета) = Тип("НастройкиКомпоновкиДанных") Тогда
				Продолжить;
			КонецЕсли;
			
			СтрокаНастроекДо = ОбщегоНазначения.ЗначениеВСтрокуXML(НастройкиОтчета);
			ОбработатьНастройкиОтчета(НастройкиОтчета, ПараметрыВыполнения);
			СтрокаНастроекПосле = ОбщегоНазначения.ЗначениеВСтрокуXML(НастройкиОтчета);
			Если СтрокаНастроекДо = СтрокаНастроекПосле Тогда
				Продолжить;
			КонецЕсли;
			
			ТекущийОбъект.Настройки = Новый ХранилищеЗначения(НастройкиОтчета);
			ТекущийОбъект.ЗаписьИсторииДанных.КомментарийВерсии = "Замена полей в отчете после обновления";
			ТекущийОбъект.Записать();
			
			ТекущиеДанные.Изменен = Истина;
			
			СообщитьОбИзмененииВариантаОтчета(ТекущийОбъект);
		
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ДляВызоваИзДругихПодсистем

// Сведения о внешней обработке
// 
// Возвращаемое значение:
//  см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке 
//
Функция СведенияОВнешнейОбработке() Экспорт
    
    ПараметрыРегистрации                    = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
    ПараметрыРегистрации.Вид                = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
    ПараметрыРегистрации.Версия             = НомерВерсииИнструмента();
    ПараметрыРегистрации.БезопасныйРежим    = Ложь;
    
    Команда = ПараметрыРегистрации.Команды.Добавить();
    Команда.Представление        = Метаданные().Представление();
    Команда.Идентификатор        = Метаданные().Имя;
    Команда.Использование        = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
    Команда.ПоказыватьОповещение = Ложь;
    
    Возврат ПараметрыРегистрации; 
   
КонецФункции

// Номер версии инструмента
// 
// Возвращаемое значение:
//  Строка 
//
Функция НомерВерсииИнструмента() Экспорт
    
    Возврат "2.2.1";
		
КонецФункции

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Заменяемые поля.
// 
// Возвращаемое значение:
//  Массив из ОбработкаТабличнаяЧастьСтрока.ИТМ_ОбновлениеВариантовОтчетов.ЗаменяемыеПоля
Функция ЗаменяемыеПоля() Экспорт
	
	Возврат ЗаменяемыеПоля.НайтиСтроки(Новый Структура("Заменять", Истина));
	
КонецФункции

// Параметры обработки настроек.
// 
// Возвращаемое значение:
//  Структура - :
// * ЗаменяемыеПоля - см. ЗаменяемыеПоля
Функция ПараметрыОбработкиНастроек() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("ЗаменяемыеПоля", ЗаменяемыеПоля());
	Возврат Результат;
	
КонецФункции

// Обработать настройки отчета.
// 
// Параметры:
//  ИсточникДанных - НастройкиКомпоновкиДанных
//   - КоллекцияЗначенийПараметровКомпоновкиДанных
//   - ОформлениеКомпоновкиДанных
//   - ВариантыПользовательскогоПоляВыборКомпоновкиДанных
//   - ОформляемыеПоляКомпоновкиДанных
//   - ОтборКомпоновкиДанных
//   - ВыбранныеПоляКомпоновкиДанных
//   - АвтоВыбранноеПолеКомпоновкиДанных
//   - СтруктураНастроекКомпоновкиДанных
//   - ГруппаЭлементовОтбораКомпоновкиДанных
//   - ГруппировкаДиаграммыКомпоновкиДанных
//   - ПолеГруппировкиКомпоновкиДанных
//   - ГруппаВыбранныхПолейКомпоновкиДанных
//   - АвтоПолеГруппировкиКомпоновкиДанных
//   - ГруппировкаКомпоновкиДанных
//   - ВыбранноеПолеКомпоновкиДанных
//   - ЭлементОтбораКомпоновкиДанных
//   - УсловноеОформлениеКомпоновкиДанных
//   - ПорядокКомпоновкиДанных
//   - ТаблицаКомпоновкиДанных
//   - ЭлементПорядкаКомпоновкиДанных
//   - НастройкиВложенногоОбъектаКомпоновкиДанных
//   - ПользовательскоеПолеВыборКомпоновкиДанных
//   - АвтоЭлементПорядкаКомпоновкиДанных
//   - ОформляемоеПолеКомпоновкиДанных
//   - ЭлементУсловногоОформленияКомпоновкиДанных
//   - ДиаграммаКомпоновкиДанных
//   - ВариантПользовательскогоПоляВыборКомпоновкиДанных
//   - ГруппировкаТаблицыКомпоновкиДанных
//   - ПользовательскоеПолеВыражениеКомпоновкиДанных
//   - ЗначениеПараметраНастроекКомпоновкиДанных
//  ПараметрыВыполнения - см. ПараметрыОбработкиНастроек
//
Процедура ОбработатьНастройкиОтчета(ИсточникДанных, Знач ПараметрыВыполнения = Неопределено) Экспорт
	
	Если ПараметрыВыполнения = Неопределено Тогда
		ПараметрыВыполнения = ПараметрыОбработкиНастроек();
	КонецЕсли;
	
	КоллекцияДанных = Новый Массив; //Массив из см. ОбработатьНастройкиОтчета.ИсточникДанных
	КоллекцияДанных.Добавить(ИсточникДанных);
	
	Для Каждого Данные Из КоллекцияДанных Цикл
		
		ПроверяемыеСвойства = Новый Массив; //Массив из Строка
	
		ОбработатьНастройкиОтчета_ОбработатьДанные(КоллекцияДанных, Данные, ПроверяемыеСвойства);
		
		Если ЗначениеЗаполнено(ПроверяемыеСвойства) Тогда
			ОбработатьПоляНастройкиОтчета(Данные, ПроверяемыеСвойства, ПараметрыВыполнения);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Новый путь поля компоновки.
// 
// Параметры:
//  ТекущийПуть - Строка
//  ПутьДо - Строка
//  ПутьПосле - Строка
// 
// Возвращаемое значение:
//  Строка
Функция НовыйПутьПоляКомпоновки(ТекущийПуть, ПутьДо, ПутьПосле) Экспорт
	
	ТекущийПутьВрег = Врег(ТекущийПуть);
	ПутьДоВрег = Врег(ПутьДо);
	
	Если ТекущийПутьВрег = ПутьДоВрег Тогда
		НовыйПуть = ПутьПосле;
	ИначеЕсли СтрНачинаетсяС(ТекущийПутьВрег, ПутьДоВрег + ".") Тогда
		НовыйПуть = ПутьПосле + Сред(ТекущийПуть, СтрДлина(ПутьДо) + 1);
	Иначе
		НовыйПуть = "";
	КонецЕсли;
	
	Возврат НовыйПуть;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура Инициализировать_Очистка()
	
	ЗаменяемыеПоля.Очистить();
	ОбновляемыеВарианты.Очистить();
	
КонецПроцедуры

Процедура Инициализировать_Компоновщик(ИдентификаторФормы)
	
	КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных();
	СхемаКомпоновки = ПолучитьМакет("СхемаВыбора"); //СхемаКомпоновкиДанных
	АдресСхемыКомпоновки = ПоместитьВоВременноеХранилище(СхемаКомпоновки, ИдентификаторФормы);
	ИсточникНастроек = Новый ИсточникДоступныхНастроекКомпоновкиДанных(АдресСхемыКомпоновки);
	КомпоновщикНастроек.Инициализировать(ИсточникНастроек);
    КомпоновщикНастроек.ЗагрузитьНастройки(СхемаКомпоновки.НастройкиПоУмолчанию);
	
КонецПроцедуры

Процедура Инициализировать_ОтборОтчета(Знач Отчет = Неопределено)
	
	Если Отчет = Неопределено Тогда
		Отчет = Справочники.ИдентификаторыОбъектовМетаданных.ПустаяСсылка(); 
	КонецЕсли;
    
    ОтборКомпоновки = КомпоновщикНастроек.Настройки.Отбор.Элементы;
    ЭлементОтбора = ОтборКомпоновки.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
    ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных("Отчет");
    ЭлементОтбора.ПравоеЗначение = Отчет;
    ЭлементОтбора.ИдентификаторПользовательскойНастройки = "Отбор по отчету";
    
КонецПроцедуры

Процедура ОбработатьПоляНастройкиОтчета(Знач Данные, Знач ПроверяемыеСвойства, ПараметрыВыполнения)
	
	Для Каждого ПроверяемоеСвойство Из ПроверяемыеСвойства Цикл
		
		ТекущееПолеКомпоновки = Данные[ПроверяемоеСвойство]; //ПолеКомпоновкиДанных
		ТекущийПутьПоля = Строка(ТекущееПолеКомпоновки);
		
		Для Каждого ПолеЗамены Из ПараметрыВыполнения.ЗаменяемыеПоля Цикл
			
			Если ТипЗнч(ТекущееПолеКомпоновки) = Тип("ПолеКомпоновкиДанных") Тогда
				
				НовыйАдресКомпоновки = НовыйПутьПоляКомпоновки(
					ТекущийПутьПоля, ПолеЗамены.ПутьДо, ПолеЗамены.ПутьПосле);
				
				Если ЗначениеЗаполнено(НовыйАдресКомпоновки) Тогда
					//@skip-check statement-type-change
					Данные[ПроверяемоеСвойство] = Новый ПолеКомпоновкиДанных(НовыйАдресКомпоновки);
					Прервать;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
КонецПроцедуры

// Это тип НастройкиКомпоновкиДанных и подобное им по составу свойств.
// 
// Параметры:
//  Тип - Тип
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоТипНастройкиКомпоновкиДанныхИПодобныеИм(Тип)
	
	Возврат Тип = Тип("НастройкиКомпоновкиДанных")
		ИЛИ Тип = Тип("ГруппировкаКомпоновкиДанных")
		ИЛИ Тип = Тип("ГруппировкаТаблицыКомпоновкиДанных")
		ИЛИ Тип = Тип("ГруппировкаДиаграммыКомпоновкиДанных")
		ИЛИ Тип = Тип("ДиаграммаКомпоновкиДанных")
		ИЛИ Тип = Тип("ТаблицаКомпоновкиДанных");
	
КонецФункции

// Это тип объекта, который содержит свойство Элементы с элементами компоновки.
// 
// Параметры:
//  Тип - Тип
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоТипСЭлементамиКомпоновки(Тип)
	
	Возврат Тип = Тип("ВыбранныеПоляКомпоновкиДанных")
		ИЛИ Тип = Тип("ГруппаВыбранныхПолейКомпоновкиДанных")
		ИЛИ Тип = Тип("ОтборКомпоновкиДанных")
		ИЛИ Тип = Тип("ГруппаЭлементовОтбораКомпоновкиДанных")
		ИЛИ Тип = Тип("ПорядокКомпоновкиДанных")
		ИЛИ Тип = Тип("ПользовательскиеПоляКомпоновкиДанных")
		ИЛИ Тип = Тип("ВариантыПользовательскогоПоляВыборКомпоновкиДанных")
		ИЛИ Тип = Тип("ОформляемыеПоляКомпоновкиДанных")
		ИЛИ Тип = Тип("ПоляГруппировкиКомпоновкиДанных")
		ИЛИ Тип = Тип("УсловноеОформлениеКомпоновкиДанных")
		ИЛИ Тип = Тип("ОформлениеКомпоновкиДанных")
		ИЛИ Тип = Тип("ПользовательскиеНастройкиКомпоновкиДанных");
	
КонецФункции

// Это тип коллекции элементов компоновки.
// 
// Параметры:
//  Тип - Тип
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоТипКоллекцияЭлементовКомпоновки(Тип)
	
	Возврат Тип = Тип("КоллекцияЭлементовСтруктурыНастроекКомпоновкиДанных")
		ИЛИ Тип = Тип("КоллекцияЭлементовСтруктурыТаблицыКомпоновкиДанных")
		ИЛИ Тип = Тип("КоллекцияЭлементовСтруктурыДиаграммыКомпоновкиДанных")
		ИЛИ Тип = Тип("КоллекцияЗначенийПараметровКомпоновкиДанных");
	
КонецФункции

// Это тип элемента компоновки со свойством Поле.
// 
// Параметры:
//  Тип - Тип
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоТипЭлементаКомпоновкиСоСвойствомПоле(Тип)
	
	Возврат Тип = Тип("ВыбранноеПолеКомпоновкиДанных")
		ИЛИ Тип = Тип("ЭлементПорядкаКомпоновкиДанных")
		ИЛИ Тип = Тип("ОформляемоеПолеКомпоновкиДанных")
		ИЛИ Тип = Тип("ПолеГруппировкиКомпоновкиДанных");
	
КонецФункции

// Это тип элемента компоновки со значением параметра.
// 
// Параметры:
//  Тип - Тип
// 
// Возвращаемое значение:
//  Булево
Функция ЭтоТипЗначениеПараметра(Тип)
	
	Возврат Тип = Тип("ЗначениеПараметраКомпоновкиДанных")
		ИЛИ Тип = Тип("ЗначениеПараметраНастроекКомпоновкиДанных");
	
КонецФункции

Процедура ОбработатьНастройкиОтчета_ОбработатьДанные(КоллекцияДанных, Данные, ПроверяемыеСвойства)
	
	ТипДанных = ТипЗнч(Данные);
		
	Если ЭтоТипНастройкиКомпоновкиДанныхИПодобныеИм(ТипДанных) Тогда // sonar:IfWithoutElse - не требуется
		
		ОбработатьНастройкиОтчета_НастройкиКомпоновкиДанныхИПодобныеИм(Данные, КоллекцияДанных);
		
	ИначеЕсли ЭтоТипСЭлементамиКомпоновки(ТипДанных) Тогда
		
		ОбработатьНастройкиОтчета_ТипСЭлементами(Данные, КоллекцияДанных);
		
	ИначеЕсли ЭтоТипКоллекцияЭлементовКомпоновки(ТипДанных) Тогда
		
		ОбработатьНастройкиОтчета_КоллекцияЭлементов(Данные, КоллекцияДанных);
		
	ИначеЕсли ТипДанных = Тип("НастройкиВложенногоОбъектаКомпоновкиДанных") Тогда
		
		КоллекцияДанных.Добавить(Данные.Настройки);
		
	ИначеЕсли ТипДанных = Тип("ПользовательскоеПолеВыборКомпоновкиДанных") Тогда
		
		КоллекцияДанных.Добавить(Данные.Варианты);
		
	ИначеЕсли ТипДанных = Тип("ВариантПользовательскогоПоляВыборКомпоновкиДанных") Тогда
		
		КоллекцияДанных.Добавить(Данные.Отбор);
		ПроверяемыеСвойства.Добавить("Значение");
		
	ИначеЕсли ТипДанных = Тип("ГруппировкаКомпоновкиДанных") Тогда
		
		КоллекцияДанных.Добавить(Данные.Отбор);
		
	ИначеЕсли ТипДанных = Тип("ЭлементУсловногоОформленияКомпоновкиДанных") Тогда
		
		КоллекцияДанных.Добавить(Данные.Отбор);
		КоллекцияДанных.Добавить(Данные.Поля);
		КоллекцияДанных.Добавить(Данные.Оформление);
		
	ИначеЕсли ЭтоТипЭлементаКомпоновкиСоСвойствомПоле(ТипДанных) Тогда
		
		ПроверяемыеСвойства.Добавить("Поле");
		
	ИначеЕсли ТипДанных = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
		
		ПроверяемыеСвойства.Добавить("ЛевоеЗначение");
		ПроверяемыеСвойства.Добавить("ПравоеЗначение");
		
	ИначеЕсли ЭтоТипЗначениеПараметра(ТипДанных) Тогда
		
		ПроверяемыеСвойства.Добавить("Значение");
		КоллекцияДанных.Добавить(Данные.ЗначенияВложенныхПараметров);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьНастройкиОтчета_НастройкиКомпоновкиДанныхИПодобныеИм(Данные, КоллекцияДанных)
	
	ИменаТребуемыхСвойств = "Выбор,Отбор,Порядок,УсловноеОформление,
	|ПользовательскиеПоля,ПоляГруппировки,Структура,Колонки,Строки,Серии,Точки";
	ТребуемыеСвойства = Новый Структура(ИменаТребуемыхСвойств);
	
	ЗаполнитьЗначенияСвойств(ТребуемыеСвойства, Данные);
	Для Каждого КлючИЗначение Из ТребуемыеСвойства Цикл
		ТекущаяКоллекция = КлючИЗначение.Значение; //см. ОбработатьНастройкиОтчета.ИсточникДанных
		Если ТекущаяКоллекция <> Неопределено Тогда
			КоллекцияДанных.Добавить(ТекущаяКоллекция);
		КонецЕсли;							
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьНастройкиОтчета_ТипСЭлементами(Данные, КоллекцияДанных)
	
	Для Каждого Элемент Из Данные.Элементы Цикл
		КоллекцияДанных.Добавить(Элемент);
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработатьНастройкиОтчета_КоллекцияЭлементов(Данные, КоллекцияДанных)
	
	Для Каждого Элемент Из Данные Цикл
		КоллекцияДанных.Добавить(Элемент);
	КонецЦикла;
	
КонецПроцедуры

Процедура СообщитьОбИзмененииВариантаОтчета(ВариантОтчета)
		
	ТекстСообщения = СтрШаблон("Изменены настройки варианта %1", ВариантОтчета);
	ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
	ЗаписьЖурналаРегистрации(СобытиеЖурналаРегистрации, УровеньЖурналаРегистрации.Информация, 
		ВариантОтчета.Метаданные(), ВариантОтчета.Ссылка, ТекстСообщения, 
		РежимТранзакцииЗаписиЖурналаРегистрации.Транзакционная);
	
КонецПроцедуры

Функция РазделительДляЗаполненияЗаменяемыхПолей()
	
	Возврат "-";
	
КонецФункции

#КонецОбласти

#Область Инициализация

СобытиеЖурналаРегистрации = СтрШаблон("Обработка.%1", Метаданные().Имя);

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
