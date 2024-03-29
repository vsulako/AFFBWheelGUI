# AFFBWheelGUI

[![United States](https://raw.githubusercontent.com/stevenrskelton/flag-icon/master/png/16/country-4x3/us.png "United States") Description in English](/README.md)

Программа (*далее GUI*) для изменения настроек контроллера [AFFBWheel](https://github.com/vsulako/AFFBWheel/blob/master/readme_rus.md).

## Скачать

**[Последняя скомпилированная версия (Windows x86)](https://github.com/vsulako/AFFBWheelGUI/releases/latest)** <br>
**[Прошлые версии](https://github.com/vsulako/AFFBWheelGUI/releases)**

## Вкладка `Inputs`

Основные настройки руля, осей и кнопок.

![](/images/affbwheelgui_inputs.png)

- **Axis #0, #1, #2, ....** - Отображает текущее состояние осей руль, газ, тормоз и тд.
- **Range (селектор)** - устанавливает угол поворота рулевого колеса от упора до упора, так же можно ввести любое свое значение.
- **Center (кнопка)** - запоминает текущее положение руля как центральное, только до повторного включения устройства, так же устанавливается при включении автоматически.
- **Min/Max (ввод)** - устанавливает минимальное и максимальное значение для ввода оси.
- **Center (ввод)** - устанавливает центральное положение оси, активно только если установлен флаг **Has center**.
- **Deadzone (ввод)** - устанавливает мертвую зону центра для аналоговой оси. Если для оси установлено центральное положение (**Has center**), можно добавить мертвую зону в центр. Пример: центр оси установлен в 530, а мертвая зона в 10. Теперь ось будет сообщать значение 0 когда показания будут находиться между 520 и 540. Это касается только центра. Мертвая зона не работает, если центр оси отключен. Чтобы установить мертвые зоны по краям, устанавливайте минимум/максимум несколько меньше чем реальные границы.
- **Set Min (кнопка)** - устанавливает минимальное значение оси. Нужно установить ось в минимальном положении и нажать кнопку.
- **Set Max (кнопка)** - устанавливает максимальное значение оси. Нужно установить ось в максимальное положении и нажать кнопку.
- **Set Center (кнопка)** - устанавливает центральное значение оси. Нужно установить ось в центральное положении и нажать кнопку.
- **Autolimit (переключатель)** - включает автоматическую установку минимума/максимума для аналоговой оси. Если это включено, то при любом превышении существующих границ текущее значение становится новой границей. (Иначе говоря: включите, прожмите педаль до упора и назад, выключите - готово, границы определены). Центральное положение и мертвая зона будут отключены.
- **Has center (переключатель)** - задает может ли ось иметь центральное положение.
- **Has center (переключатель)** - задает может ли ось иметь центральное положение.
- **Output disabled (переключатель)** - отключает ввод с оси. Например если ось не используется, чтобы убрать шум (колебания значений при отключенной оси).
- **Trim (селектор)** - устанавливает значение округления для аналоговой оси. Побитово уменьшает разрешение исходных (raw) показаний оси для борьбы с нежелательным шумом. Например, при установке значения 3 показания будут меняться с шагом 8 (2 в степени 3). Если на оси присутствует шум, можно попробовать увеличить это значение (однако, все же лучше найти причину шума а не скрывать его таким образом).
  
- **Buttons** - здесь отображаются и настраиваются кнопки, можно протестировать работу кнопок.
- **Center button (селектор)** - можно выбрать кнопку, нажатие которой будет сбрасывать и запоминать текущее положение руля (аналогично действию **Center (кнопка)**).
- **Debounce (ввод)** - устанавливает задержку срабатывания кнопок. Если это значение больше 0, кнопки будут регистрировать изменения только после задержки (1 цикл - около 1мс)
Если у кнопок проблема с дребезгом - попробуйте увеличить это значение.

## Вкладка `Force Feedback`

Позволяет изменить коэффициенты усиления для каждого из эффектов обратной связи DirectX.

![](/images/affbwheelgui_forcefeedback.png)

#### All:

Устанавливает, увеличивает или уменьшает, силу всех эффектов ниже кроме **Endstop**.

#### Constant:

Постоянная сила, действует в одном направлении.

*Пример:* игра обычно использует постоянную силу для имитации перегрузок. Так создается сопротивление при прохождении поворота на скорости.

#### Ramp:

Сила, которая постоянно увеличивается или уменьшается. Нарастающая сила может продолжаться в одном направлении или может начинаться как сильный толчок в одном направлении, ослабевать, останавливаться, а затем усиливаться в противоположном направлении.

*Пример:* сопротивление веса автомобиля и перенос веса шасси в повороте.

#### Square, Sine, Triangle, Sawtooth Up/Down:

Усилие изменяется по периодической зависимости от времени (прямоугольный/треугольный/пилообразный сигнал/синусоида), может применяться для создания вибрации.

*Пример:* некоторые игры могут создавать вибрации при повреждении автомобиля.

#### Spring:

Это сила, которая увеличивается в зависимости от того, насколько далеко вы находитесь от определенного положения на колесе. Усилие зависит от положения руля.

*Пример:* имитация силы возвращающей руль в центральное положение.

#### Damper:

Усилие зависит от угловой скорости, применяется для имитации сопротивления руля вращению (нагруженности).

*Пример:* создание сопротивления на руле когда пашина стоит на месте и уменьшение этого эффекта на скорости.

#### Inertial:

Усилие зависит от углового ускорения, применяется имитации сопротивления изменению скорости вращения (инерцию).

#### Friction:

Создает постоянное усилие, сопротивляющееся вращению (аналогично **Damper**, но чуть иначе) Тоже должно имитировать нагруженность.

*Пример:* трение колес автомобиля об дорожное покрытие.

#### Endstop:

Это сила конечной остановки руля. То есть когда руль достигает крайнего положения включается двигатель обратной связи и не дает рулю прокручиваться дальше.

*Пример:* если задан угол поворота руля 900°, то если прокрутить руль от центра на 450° в сторону, дальнейший поворот руля будет ограничен.

*На практике в играх зачастую применяется только эффект Constant, иногда еще Spring и Damper. Остальные едва ли можно встретить.*

*Лучше не трогать эти настройки а силу ОС регулировать в игре, если есть такая возможность.*

#### Max velocity for Damper effect:

Максимальное значение скорости для эффекта демпфера.
При увеличении этого параметра эффект демпфера ослабевает, и наоборот.

#### Max velocity for Friction effect:

Максимальное значение скорости для эффекта трения.
Оказывает воздействие только на действие эффекта для малых значений скорости.

#### Max acceleration for Inertial effect:

Максимальное значение ускорения для эффекта инерции.
При увеличении этого параметра эффект инерции ослабевает, и наоборот.

#### Min force:

Минимальное значение для усилия обратной связи.

*Совет:* Если вы хотите избавиться от пустоты на руле в центре, то можете попробовать увеличить **Min force** до 5-10%.

#### Max force:

Максимально возможное значение для усилия обратной связи.

#### Cut force:

Уровень обрезки усилия обратной связи.
Если результирующее значение больше чем значение **Cut force** - значение усилия будет обрезано на уровне **Cut force**.

#### FFB PWM bitdepth/frequency:

Значение по умолчанию - 9, частота 15.625кГц. Менять его не следует.
Значения больше 9 приводят к уменьшению частоты и возникновению противного писка.
Меньшие значения - только теряют в разрешении.
Настройка оставлена просто на всякий случай.

#### Endstop offset:

Уровень, с которого начнется усилие возврата руля при выходе за границы.
При увеличении значения жесткость эффекта возрастает.

*Примечание:* диапазон значений от 0 до 16383.

#### Endstop width:

ширина участка, на протяжении которого усилие возврата линейно нарастает до максимума. При увеличении значения эффект становится мягче.

*Примечание:* диапазон значений от 0 до 16383. Если вам не нравиться как ведет себя эффект остановки руля в крайнем положении попробуйте увеличить или уменьшить это значение. Если у вас мощный мотор то возможно будет наблюдаться эффект вибрации при упоре в ограничение, тогда попробуйте уменьшить **Endstop width**.

## Сохранение и сброс настроек

Внизу окна располагаются кнопки для сохранения и сброса настроек.

![](/images/affbwheelgui_bottom.png)

- **Reset settings to defaults** - сбрасывает настройки к стандартным. <br>
  *Если вы обновили прошивку или GUI и у вас возникли какие то проблемы, то попробуйте сперва сбросить настройки этой кнопкой*.
- **Load settings from EEPROM** - загрузка настроек из энергонезависимой памяти контроллера. <br>
  *Обычно все настройки загружаются автоматически при запуске программы настройки и не требуется нажимать эту кнопку*.
- **Save settings to EEPROM** - сохраняет настройки в энергонезависимую память контроллера, позволяет сохранять настройки при отключении питания контроллера. <br>
  *Не забывайте сохранять настройки после изменения и до отключения питания контроллера*.

## Требования для компиляции

- Delphi
- [JEDI Visual Component Library](https://github.com/project-jedi/jvcl)

## Известные проблемы и их решения

- В случае ошибки «Device cannot be opened» в Windows 10, попробуйте установить обновление [KB4482887](https://catalog.update.microsoft.com/Search.aspx?q=KB4482887):
<https://support.microsoft.com/en-us/topic/march-1-2019-kb4482887-os-build-17763-348-f7a9f207-0627-1fb9-cca7-29bb7b26027f>
