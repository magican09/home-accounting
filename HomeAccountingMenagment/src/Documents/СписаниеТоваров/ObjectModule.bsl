


#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

#КонецОбласти

#Область ПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ОбработкаПроведения(Отказ,Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	//Данный фрагмент построен конструктором.
	//При повторном использовании конструктора, внесенные вручную данные будут утеряны!

	// регистр ПокупкиСписания
	Движения.ПокупкиСписания.Записывать = Истина;
	Для Каждого ТекСтрокаТовары из Товары Цикл
		Движение = Движения.ПокупкиСписания.Добавить();
		Движение.Период = Дата;
		Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
		Движение.Товар = ТекСтрокаТовары.Товар;
		
		//{{КОНСТРУКТОР_ЗАПРОСА_С_ОБРАБОТКОЙ_РЕЗУЛЬТАТА
		// Данный фрагмент построен конструктором.
		// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!
		
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	ПокупкиСписанияОстаткиИОбороты.СуммаКонечныйОстаток КАК СуммаКонечныйОстаток,
			|	ПокупкиСписанияОстаткиИОбороты.КоличествоКонечныйОстаток
			|ИЗ
			|	РегистрНакопления.ПокупкиСписания.ОстаткиИОбороты(,,,, Товар.Наименование = &Наименование) КАК
			|		ПокупкиСписанияОстаткиИОбороты";
		
		Запрос.УстановитьПараметр("Наименование", ТекСтрокаТовары.Товар.Наименование);
		
		//@skip-check query-in-loop
		РезультатЗапроса = Запрос.Выполнить();
		
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
		
		СуммаОстатка =0;
		КоличествоОстатка = 0;

		ВыборкаДетальныеЗаписи.Сбросить();
		
		//@skip-check query-in-loop
		РезультатЗапроса2 = Запрос.Выполнить();
		ВыборкаДетальныеЗаписи2 = РезультатЗапроса2.Выбрать();
	
	
		УсредненнаяЦенаЗаЕдТовара  = СуммаОстатка/КоличествоОстатка;
		Движение.Сумма = ТекСтрокаТовары.Количество * УсредненнаяЦенаЗаЕдТовара;
	КонецЦикла;


	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Код процедур и функций

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Код процедур и функций

#КонецОбласти

#Область Инициализация

#КонецОбласти

#КонецЕсли
