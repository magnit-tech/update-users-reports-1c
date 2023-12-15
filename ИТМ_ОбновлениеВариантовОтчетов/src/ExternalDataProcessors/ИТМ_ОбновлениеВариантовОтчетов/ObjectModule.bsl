// @strict-types

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

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
	ЗаменяемоеПоле.ПутьДо = ПутьДо;
	ЗаменяемоеПоле.ПутьПосле = ПутьПосле;
	
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
	Для Каждого ТекущиеДанные Из ЗаменяемыеПоля() Цикл
		ТекущаяСтрока = "Обработка.НовоеЗаменяемоеПоле(""%1"", ""%2"");";
		ТекущаяСтрока = СтрШаблон(ТекущаяСтрока, ТекущиеДанные.ПутьДо, ТекущиеДанные.ПутьПосле);
		ЧастиТекста.Добавить(ТекущаяСтрока);
	КонецЦикла;
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
	
	Для Каждого ТекущиеДанные Из ОбновляемыеВарианты Цикл
		
		ТекущийОбъект = ТекущиеДанные.ВариантОтчета.ПолучитьОбъект();
		НастройкиОтчета = ТекущийОбъект.Настройки.Получить(); //НастройкиКомпоновкиДанных
		Если НЕ ТипЗнч(НастройкиОтчета) = Тип("НастройкиКомпоновкиДанных") Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаНастроекДо = ОбщегоНазначения.ЗначениеВСтрокуXML(НастройкиОтчета);
		ОбработатьНастройкиОтчета(НастройкиОтчета);
		СтрокаНастроекПосле = ОбщегоНазначения.ЗначениеВСтрокуXML(НастройкиОтчета);
		Если СтрокаНастроекДо = СтрокаНастроекПосле Тогда
			Продолжить;
		КонецЕсли;
		
		ТекущийОбъект.Настройки = Новый ХранилищеЗначения(НастройкиОтчета);
		ТекущийОбъект.ЗаписьИсторииДанных.КомментарийВерсии = "Замена полей в отчете после обновления";
		ТекущийОбъект.Записать();
		
		ОбщегоНазначения.СообщитьПользователю(СтрШаблон("Изменены настройки варианта %1", ТекущийОбъект));
		
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
    
    Возврат "2.1.1";
		
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

// Обработать настройки отчета.
// 
// Параметры:
//  Данные - НастройкиКомпоновкиДанных
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
Процедура ОбработатьНастройкиОтчета(Данные) Экспорт //sonar:MethodCognitiveComplexity
	
	ПроверяемыеСвойства = Новый Массив; //Массив из Строка
	
	ТипДанных = ТипЗнч(Данные);
	
	Если ЭтоТипНастройкиКомпоновкиДанныхИПодобныеИм(ТипДанных) Тогда
		
		ИменаТребуемыхСвойств = "Выбор,Отбор,Порядок,УсловноеОформление,
		|ПользовательскиеПоля,ПоляГруппировки,Структура,Колонки,Строки,Серии,Точки";
		ТребуемыеСвойства = Новый Структура(ИменаТребуемыхСвойств);
		
		ЗаполнитьЗначенияСвойств(ТребуемыеСвойства, Данные);
		Для Каждого КлючИЗначение Из ТребуемыеСвойства Цикл
			ТекущаяКоллекция = КлючИЗначение.Значение; //см. ОбработатьНастройкиОтчета.Данные
			Если ТекущаяКоллекция <> Неопределено Тогда
				ОбработатьНастройкиОтчета(ТекущаяКоллекция);
			КонецЕсли;							
		КонецЦикла;
		
	ИначеЕсли ЭтоТипСЭлементамиКомпоновки(ТипДанных) Тогда
		
		Для Каждого Элемент Из Данные.Элементы Цикл
			ОбработатьНастройкиОтчета(Элемент);
		КонецЦикла;
		
	ИначеЕсли ЭтоТипКоллекцияЭлементовКомпоновки(ТипДанных) Тогда
		
		Для Каждого Элемент Из Данные Цикл
			ОбработатьНастройкиОтчета(Элемент);
		КонецЦикла;
		
	ИначеЕсли ТипДанных = Тип("НастройкиВложенногоОбъектаКомпоновкиДанных") Тогда
		
		ОбработатьНастройкиОтчета(Данные.Настройки);
		
	ИначеЕсли ТипДанных = Тип("ПользовательскоеПолеВыборКомпоновкиДанных") Тогда
		
		ОбработатьНастройкиОтчета(Данные.Варианты);
		
	ИначеЕсли ТипДанных = Тип("ВариантПользовательскогоПоляВыборКомпоновкиДанных") Тогда
		
		ОбработатьНастройкиОтчета(Данные.Отбор);
		ПроверяемыеСвойства.Добавить("Значение");
		
	ИначеЕсли ТипДанных = Тип("ГруппировкаКомпоновкиДанных") Тогда
		
		ОбработатьНастройкиОтчета(Данные.Отбор);
		
	ИначеЕсли ТипДанных = Тип("ЭлементУсловногоОформленияКомпоновкиДанных") Тогда
		
		ОбработатьНастройкиОтчета(Данные.Отбор);
		ОбработатьНастройкиОтчета(Данные.Поля);
		ОбработатьНастройкиОтчета(Данные.Оформление);
		
	ИначеЕсли ЭтоТипЭлементаКомпоновкиСоСвойствомПоле(ТипДанных) Тогда
		
		ПроверяемыеСвойства.Добавить("Поле");
		
	ИначеЕсли ТипДанных = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
		
		ПроверяемыеСвойства.Добавить("ЛевоеЗначение");
		ПроверяемыеСвойства.Добавить("ПравоеЗначение");
		
	ИначеЕсли ТипДанных = Тип("ЗначениеПараметраКомпоновкиДанных")
		ИЛИ ТипДанных = Тип("ЗначениеПараметраНастроекКомпоновкиДанных") Тогда
		
		ПроверяемыеСвойства.Добавить("Значение");
		ОбработатьНастройкиОтчета(Данные.ЗначенияВложенныхПараметров);
		
	Иначе
		
		Возврат; // Неподдерживаемый тип
		
	КонецЕсли;
	
	ОбработатьПоляНастройкиОтчета(Данные, ПроверяемыеСвойства);

КонецПроцедуры

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

Процедура ОбработатьПоляНастройкиОтчета(Знач Данные, Знач ПроверяемыеСвойства)
	
	ТаблицаПолей = ЗаменяемыеПоля();
	
	Для Каждого ПроверяемоеСвойство Из ПроверяемыеСвойства Цикл
		
		Для Каждого ПолеЗамены Из ТаблицаПолей Цикл
			
			ПолеКомпоновкиДо = Новый ПолеКомпоновкиДанных(ПолеЗамены.ПутьДо);
			ТекущееПолеКомпоновки = Данные[ПроверяемоеСвойство]; //ПолеКомпоновкиДанных
			ТекущийПутьПоля = Строка(ТекущееПолеКомпоновки);
			Если ТипЗнч(ТекущееПолеКомпоновки) = Тип("ПолеКомпоновкиДанных") Тогда
				
				Если ТекущееПолеКомпоновки = ПолеКомпоновкиДо Тогда
					НовыйАдресКомпоновки = ПолеЗамены.ПутьПосле;
				ИначеЕсли СтрНачинаетсяС(ТекущийПутьПоля + ".", Строка(ПолеКомпоновкиДо)) Тогда
					НовыйАдресКомпоновки = Строка(ПолеЗамены.ПутьПосле) 
						+ Сред(ТекущийПутьПоля, СтрДлина(ПолеЗамены.ПутьДо) + 1);
				Иначе
					Продолжить;
				КонецЕсли;
				
				//@skip-check statement-type-change
				Данные[ПроверяемоеСвойство] = Новый ПолеКомпоновкиДанных(НовыйАдресКомпоновки);
				
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

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
