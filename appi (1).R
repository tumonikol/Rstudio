# ============================================================
# 🌸 R TASKS STUDIO — пастельный визуал (розовый + голубой)
# ============================================================
library(shiny)
library(ggplot2)

# ---------- 🎨 ПАСТЕЛЬНЫЕ СТИЛИ ----------
custom_css <- "
/* ---------- БАЗА ---------- */
body {
  font-family: 'Segoe UI', 'Helvetica Neue', Tahoma, sans-serif;
  background:
    radial-gradient(circle at 15% 20%, rgba(255, 214, 235, 0.55) 0%, transparent 45%),
    radial-gradient(circle at 85% 10%, rgba(206, 231, 255, 0.55) 0%, transparent 45%),
    radial-gradient(circle at 50% 90%, rgba(255, 240, 250, 0.6) 0%, transparent 50%),
    linear-gradient(160deg, #fff5fb 0%, #f0f7ff 50%, #fff0f6 100%);
  background-attachment: fixed;
  color: #5b5578;
  min-height: 100vh;
}

h1, h2, h3, h4 {
  font-family: 'Georgia', serif;
  letter-spacing: 0.3px;
}

/* ---------- ЗАГОЛОВКИ ---------- */
.app-title {
  text-align: center;
  font-size: 42px;
  font-weight: bold;
  background: linear-gradient(90deg,
    #ffb8d9 0%, #ff9ecf 25%, #c7b9ff 50%, #a8d8ff 75%, #ffb8d9 100%);
  background-size: 300% 100%;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: title-flow 8s ease infinite, title-in 1.2s ease;
  margin-bottom: 6px;
  filter: drop-shadow(0 3px 8px rgba(255, 158, 207, 0.35));
}
@keyframes title-flow {
  0%,100% { background-position: 0% 50%; }
  50%     { background-position: 100% 50%; }
}
@keyframes title-in {
  0%   { opacity: 0; transform: scale(0.7) translateY(-30px); }
  60%  { opacity: 1; transform: scale(1.05); }
  100% { transform: scale(1); }
}

.app-subtitle {
  text-align: center;
  color: #9b93bb;
  font-size: 15px;
  margin-bottom: 22px;
  letter-spacing: 0.5px;
  animation: soft-fade 2s ease;
}
@keyframes soft-fade {
  from { opacity: 0; transform: translateY(-8px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ---------- БОКОВАЯ ПАНЕЛЬ (стеклянная) ---------- */
.sidebar-box {
  background: rgba(255, 255, 255, 0.75);
  backdrop-filter: blur(14px);
  -webkit-backdrop-filter: blur(14px);
  border-radius: 26px;
  padding: 22px 18px;
  border: 1.5px solid rgba(255, 255, 255, 0.9);
  box-shadow:
    0 10px 34px rgba(199, 185, 255, 0.25),
    0 0 0 1px rgba(255, 214, 235, 0.4) inset;
  animation: slide-in-soft 0.9s cubic-bezier(0.34, 1.4, 0.64, 1);
}
@keyframes slide-in-soft {
  from { opacity: 0; transform: translateX(-40px); }
  to   { opacity: 1; transform: translateX(0); }
}

.sidebar-box h4 {
  color: #8a7fb5 !important;
  font-size: 16px;
  letter-spacing: 1px;
  margin-bottom: 14px;
}

/* ---------- КНОПКИ РАЗДЕЛОВ ---------- */
.sidebar-box .radio label {
  display: block;
  padding: 11px 18px;
  margin: 7px 0;
  border-radius: 30px;
  background: linear-gradient(135deg, #fff0f8 0%, #eef5ff 100%);
  color: #7a6e9e;
  font-weight: 600;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.35s cubic-bezier(0.34, 1.56, 0.64, 1);
  border: 1.5px solid rgba(255, 214, 235, 0.7);
  box-shadow: 0 2px 8px rgba(199, 185, 255, 0.12);
}
.sidebar-box .radio label:hover {
  transform: translateX(6px) scale(1.02);
  background: linear-gradient(135deg, #ffe4f2 0%, #dee9ff 100%);
  box-shadow: 0 6px 16px rgba(255, 158, 207, 0.28);
  border-color: #ffb8d9;
}
.sidebar-box .radio input[type='radio'] { display: none; }
.sidebar-box .radio input[type='radio']:checked + span {
  color: #c84d8f;
  font-weight: 700;
}

/* ---------- СЧЁТЧИК ---------- */
.score-badge {
  text-align: center;
  padding: 12px 16px;
  border-radius: 30px;
  background: linear-gradient(135deg, #ffd0e7 0%, #b8d9ff 100%);
  color: #ffffff;
  font-weight: 700;
  font-size: 15px;
  letter-spacing: 0.5px;
  box-shadow:
    0 8px 20px rgba(255, 158, 207, 0.35),
    0 0 0 2px rgba(255, 255, 255, 0.6) inset;
  margin-top: 16px;
  animation: badge-pulse 3s ease-in-out infinite;
  text-shadow: 0 1px 3px rgba(200, 77, 143, 0.3);
}
@keyframes badge-pulse {
  0%,100% { box-shadow: 0 8px 20px rgba(255,158,207,0.35), 0 0 0 2px rgba(255,255,255,0.6) inset; }
  50%     { box-shadow: 0 8px 28px rgba(168,216,255,0.55), 0 0 0 2px rgba(255,255,255,0.8) inset; }
}

/* ---------- КАРТОЧКА ЗАДАЧИ ---------- */
.task-card {
  border-radius: 22px;
  padding: 22px 26px;
  margin-bottom: 20px;
  background: linear-gradient(150deg,
    rgba(255, 250, 253, 0.95) 0%,
    rgba(245, 250, 255, 0.95) 100%);
  border: 1.5px solid rgba(255, 214, 235, 0.7);
  box-shadow:
    0 8px 26px rgba(199, 185, 255, 0.16),
    0 1px 0 rgba(255, 255, 255, 0.9) inset;
  transition: all 0.4s cubic-bezier(0.34, 1.4, 0.64, 1);
  animation: card-fade-up 0.6s ease backwards;
  position: relative;
  overflow: hidden;
}
.task-card::after {
  content: '';
  position: absolute;
  top: 0; left: -100%;
  width: 100%; height: 100%;
  background: linear-gradient(90deg,
    transparent 0%,
    rgba(255, 240, 250, 0.6) 50%,
    transparent 100%);
  transition: left 0.7s ease;
}
.task-card:hover::after { left: 100%; }

.task-card:hover {
  transform: translateY(-4px);
  border-color: #ffc2dd;
  box-shadow:
    0 18px 40px rgba(255, 158, 207, 0.28),
    0 1px 0 rgba(255, 255, 255, 1) inset;
}
@keyframes card-fade-up {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
}

.task-title {
  color: #7a6e9e;
  font-size: 19px;
  margin-bottom: 8px;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 12px;
}

/* Круглый бейдж с номером задачи */
.task-title .emoji {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 34px;
  height: 34px;
  min-width: 34px;
  border-radius: 50%;
  background: linear-gradient(135deg, #ffd0e7 0%, #b8d9ff 100%);
  color: #ffffff;
  font-size: 14px;
  font-weight: 700;
  box-shadow: 0 4px 10px rgba(255, 158, 207, 0.35);
  transition: all 0.4s ease;
}
.task-card:hover .task-title .emoji {
  transform: rotate(360deg) scale(1.1);
  box-shadow: 0 6px 16px rgba(168, 216, 255, 0.5);
}

.task-desc {
  color: #8a80a8;
  font-size: 15px;
  line-height: 1.6;
  margin-bottom: 14px;
}
.task-desc strong { color: #c84d8f; }

/* ---------- ПОЛЕ ВВОДА ---------- */
.answer-input label {
  color: #9b93bb !important;
  font-weight: 600 !important;
  font-size: 14px !important;
  margin-bottom: 6px;
}
.answer-input input[type='text'] {
  border: 2px solid #d5e6ff !important;
  border-radius: 14px !important;
  padding: 10px 16px !important;
  font-size: 15px !important;
  background: #fbfdff !important;
  color: #5b5578 !important;
  width: 100%;
  transition: all 0.3s ease;
  box-shadow: 0 2px 6px rgba(199, 185, 255, 0.1) inset;
}
.answer-input input[type='text']:focus {
  border-color: #ffb8d9 !important;
  background: #fffafd !important;
  box-shadow:
    0 0 0 4px rgba(255, 184, 217, 0.25),
    0 2px 8px rgba(199, 185, 255, 0.15) inset !important;
  outline: none;
  transform: translateY(-1px);
}
.answer-input input[type='text']::placeholder {
  color: #c7bfe0;
  font-style: italic;
}

/* ---------- КНОПКА  ПРОВЕРИТЬ ---------- */
.btn-check {
  background: linear-gradient(135deg, #ffb8d9 0%, #c7b9ff 50%, #a8d8ff 100%) !important;
  background-size: 200% 100% !important;
  border: none !important;
  border-radius: 30px !important;
  color: #ffffff !important;
  font-weight: 700 !important;
  font-size: 14px !important;
  letter-spacing: 0.6px;
  padding: 10px 28px !important;
  margin-top: 10px;
  cursor: pointer;
  transition: all 0.4s ease;
  box-shadow:
    0 8px 20px rgba(255, 158, 207, 0.4),
    0 0 0 2px rgba(255, 255, 255, 0.5) inset;
  text-shadow: 0 1px 3px rgba(200, 77, 143, 0.35);
}
.btn-check:hover {
  background-position: 100% 50% !important;
  transform: translateY(-3px) scale(1.04);
  box-shadow:
    0 12px 28px rgba(168, 216, 255, 0.5),
    0 0 0 2px rgba(255, 255, 255, 0.8) inset;
}
.btn-check:active { transform: translateY(0) scale(0.98); }

/* ---------- ОБРАТНАЯ СВЯЗЬ ---------- */
.feedback-ok {
  background: linear-gradient(135deg, #e8fbf0 0%, #d4f5ff 100%);
  border-left: 5px solid #a8e6c2;
  border-radius: 14px;
  padding: 12px 18px;
  margin-top: 12px;
  color: #4a8a6a;
  font-weight: 700;
  box-shadow: 0 4px 14px rgba(168, 230, 194, 0.3);
  animation: pop-soft 0.55s cubic-bezier(0.34, 1.56, 0.64, 1);
}
@keyframes pop-soft {
  0%   { opacity: 0; transform: scale(0.6); }
  60%  { opacity: 1; transform: scale(1.08); }
  100% { transform: scale(1); }
}

.feedback-no {
  background: linear-gradient(135deg, #fff0f5 0%, #ffe0ec 100%);
  border-left: 5px solid #ff9ecf;
  border-radius: 14px;
  padding: 12px 18px;
  margin-top: 12px;
  color: #c84d8f;
  font-weight: 700;
  box-shadow: 0 4px 14px rgba(255, 158, 207, 0.28);
  animation: gentle-shake 0.55s ease;
}
@keyframes gentle-shake {
  0%,100% { transform: translateX(0); }
  25%     { transform: translateX(-6px); }
  75%     { transform: translateX(6px); }
}

.feedback-empty {
  background: linear-gradient(135deg, #fff8e8 0%, #fdf0ff 100%);
  border-left: 5px solid #ffd9a8;
  border-radius: 14px;
  padding: 12px 18px;
  margin-top: 12px;
  color: #a8834a;
  font-weight: 700;
  box-shadow: 0 4px 14px rgba(255, 217, 168, 0.3);
}

/* ---------- РАСКРЫВАЮЩИЕСЯ БЛОКИ ---------- */
details {
  margin-top: 12px;
  border-radius: 14px;
  overflow: hidden;
  border: 1.5px dashed #d5e6ff;
  transition: border-color 0.3s ease;
}
details:hover { border-color: #ffc2dd; }

details summary {
  cursor: pointer;
  padding: 10px 16px;
  background: linear-gradient(135deg, #f0f7ff 0%, #fff0f8 100%);
  color: #7a6e9e;
  font-weight: 600;
  font-size: 13.5px;
  letter-spacing: 0.3px;
  transition: all 0.3s ease;
  user-select: none;
  list-style: none;
}
details summary::-webkit-details-marker { display: none; }
details summary::before {
  content: '▸ ';
  color: #ff9ecf;
  font-weight: 700;
  display: inline-block;
  transition: transform 0.3s ease;
}
details[open] summary::before { content: '▾ '; }
details summary:hover {
  background: linear-gradient(135deg, #e8f2ff 0%, #ffe8f4 100%);
  padding-left: 22px;
  color: #c84d8f;
}

details pre {
  background: linear-gradient(135deg, #3a3560 0%, #2d2a4d 100%);
  color: #ffd9ec;
  padding: 14px 18px;
  margin: 0;
  overflow-x: auto;
  font-size: 13px;
  line-height: 1.7;
  font-family: 'Consolas', 'Courier New', monospace;
  border-radius: 0 0 12px 12px;
}

details p {
  padding: 12px 18px;
  margin: 0;
  background: #fdf9ff;
  color: #8a80a8;
  font-size: 14px;
  line-height: 1.6;
}

/* ---------- ЗАГОЛОВОК РАЗДЕЛА ---------- */
.section-title {
  text-align: center;
  font-size: 26px;
  font-weight: 700;
  color: #8a7fb5;
  margin: 18px 0 22px;
  letter-spacing: 1px;
  animation: pop-soft 0.8s ease;
  position: relative;
  padding-bottom: 14px;
}
.section-title::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 80px;
  height: 3px;
  border-radius: 3px;
  background: linear-gradient(90deg, #ffb8d9, #a8d8ff);
  box-shadow: 0 2px 8px rgba(255, 158, 207, 0.5);
}

/* ---------- ДЕКОР ---------- */
.deco {
  text-align: center;
  font-size: 55px;
  animation: float-soft 3.5s ease-in-out infinite;
  margin: 4px 0 8px;
  filter: drop-shadow(0 4px 12px rgba(255, 158, 207, 0.35));
}
@keyframes float-soft {
  0%,100% { transform: translateY(0) rotate(-2deg); }
  50%     { transform: translateY(-10px) rotate(2deg); }
}

/* ---------- ПЛАВАЮЩИЕ ЭЛЕМЕНТЫ ---------- */
.heart {
  position: fixed;
  bottom: -50px;
  font-size: 22px;
  animation: rise-soft 14s linear infinite;
  opacity: 0;
  pointer-events: none;
  z-index: 0;
}
.heart:nth-child(1) { left: 6%;  animation-delay: 0s;   }
.heart:nth-child(2) { left: 24%; animation-delay: 3s;   }
.heart:nth-child(3) { left: 48%; animation-delay: 6.5s; }
.heart:nth-child(4) { left: 70%; animation-delay: 2s;   }
.heart:nth-child(5) { left: 88%; animation-delay: 8.5s; }

@keyframes rise-soft {
  0%   { transform: translateY(0) rotate(0deg) scale(0.7); opacity: 0; }
  15%  { opacity: 0.65; }
  85%  { opacity: 0.5; }
  100% { transform: translateY(-110vh) rotate(340deg) scale(1.15); opacity: 0; }
}

/* ---------- СКРОЛЛБАР ---------- */
::-webkit-scrollbar { width: 11px; }
::-webkit-scrollbar-track { background: #fdf6fb; }
::-webkit-scrollbar-thumb {
  background: linear-gradient(135deg, #ffc2dd 0%, #b8d9ff 100%);
  border-radius: 10px;
  border: 2px solid #fdf6fb;
}
::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(135deg, #ffb8d9 0%, #a8d8ff 100%);
}
"

# ============================================================
# ШАБЛОН КАРТОЧКИ
# ============================================================
task_ui <- function(id, title, description, solution_code,
                    emoji = "*", plot_output = FALSE, hint = NULL) {
  ns <- NS(id)
  div(class = "task-card",
      h4(class = "task-title",
         span(class = "emoji", emoji),
         span(title)
      ),
      p(class = "task-desc", strong("Условие: "), description),
      if (plot_output) plotOutput(ns("plot"), height = "300px"),
      div(class = "answer-input",
          textInput(ns("answer"), "Твой ответ:", placeholder = "Введи ответ сюда...")
      ),
      actionButton(ns("check"), "Проверить", class = "btn-check"),
      uiOutput(ns("feedback")),
      if (!is.null(hint)) {
        tags$details(
          tags$summary("Подсказка"),
          tags$p(hint)
        )
      },
      tags$details(
        tags$summary("Показать решение (код R)"),
        tags$pre(solution_code)
      )
  )
}

# ============================================================
# 1. МАТЕМАТИКА
# ============================================================
math_tasks <- list(
  list(id="m1", emoji="1", title="Квадратное уравнение",
       desc="Найди положительный корень уравнения x^2 - 5x + 6 = 0",
       hint="Дискриминант D = b^2 - 4ac. Или разложи: (x-2)(x-3)=0",
       code='a<-1; b<--5; c<-6\nD <- b^2 - 4*a*c\nx1 <- (-b+sqrt(D))/(2*a)\nx2 <- (-b-sqrt(D))/(2*a)\nprint(c(x1, x2))',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 3) < 0.01),
  list(id="m2", emoji="2", title="Факториал",
       desc="Вычисли 10!",
       hint="factorial(10) или prod(1:10)",
       code='factorial(10)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 3628800) < 0.5),
  list(id="m3", emoji="3", title="Сумма ряда",
       desc="Найди сумму чисел от 1 до 100",
       hint="Формула Гаусса: n(n+1)/2",
       code='sum(1:100)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 5050) < 0.01),
  list(id="m4", emoji="4", title="НОД",
       desc="Найди НОД чисел 48 и 180",
       hint="48 = 2^4 * 3, 180 = 2^2 * 3^2 * 5",
       code='a<-48; b<-180\ng<-function(x,y) ifelse(y==0, x, g(y, x %% y))\ng(a, b)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 12) < 0.01),
  list(id="m5", emoji="5", title="Производная",
       desc="f(x) = x^3 + 2x^2 - 5x + 1. Чему равно f'(0)?",
       hint="f'(x) = 3x^2 + 4x - 5. Подставь x = 0.",
       code="# f'(x) = 3x^2 + 4x - 5\n# f'(0) = -5",
       check=function(s) abs(suppressWarnings(as.numeric(s)) + 5) < 0.01),
  list(id="m6", emoji="6", title="Интеграл",
       desc="Интеграл от 0 до 1 функции x^2 (округли до 2 знаков)",
       hint="Первообразная x^3/3.",
       code='integrate(function(x) x^2, 0, 1)$value',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 0.333) < 0.02),
  list(id="m7", emoji="7", title="Простые числа",
       desc="Сколько простых чисел в диапазоне от 1 до 50?",
       hint="2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47",
       code='x <- 2:50\nlength(x[sapply(x, function(y) all(y %% 2:max(2,floor(sqrt(y))) != 0))])',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 15) < 0.01),
  list(id="m8", emoji="8", title="Определитель",
       desc="Определитель матрицы 3x3 со строками [1,2,3], [4,5,6], [7,8,10]",
       hint="det(M), где M <- matrix(..., byrow=TRUE)",
       code='M<-matrix(c(1,2,3,4,5,6,7,8,10), nrow=3, byrow=TRUE)\ndet(M)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) + 3) < 0.01),
  list(id="m9", emoji="9", title="Комбинаторика",
       desc="Сколькими способами выбрать 3 предмета из 10? C(10,3)",
       hint="choose(10,3)",
       code='choose(10, 3)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 120) < 0.01),
  list(id="m10",emoji="10", title="Числа Фибоначчи",
       desc="10-е число Фибоначчи (F1=1, F2=1)",
       hint="1, 1, 2, 3, 5, 8, 13, 21, 34, 55",
       code='f<-numeric(15); f[1]<-f[2]<-1\nfor(i in 3:15) f[i]<-f[i-1]+f[i-2]\nf[10]',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 55) < 0.01)
)

# ============================================================
# 2. АНАЛИЗ ДАННЫХ
# ============================================================
data(mtcars)

# Пастельная тема для графиков
theme_pastel <- function() {
  theme_minimal(base_size = 13) +
    theme(
      plot.title  = element_text(color = "#8a7fb5", face = "bold",
                                 hjust = 0.5, size = 15),
      axis.title  = element_text(color = "#9b93bb"),
      axis.text   = element_text(color = "#8a80a8"),
      panel.grid.major = element_line(color = "#f0e8ff", linewidth = 0.4),
      panel.grid.minor = element_blank(),
      plot.background  = element_rect(fill = "#fdfaff", color = NA),
      panel.background = element_rect(fill = "#fdfaff", color = NA)
    )
}

stat_tasks <- list(
  list(id="s1", emoji="1", title="Описательная статистика",
       desc="Среднее значение mpg (округли до 2 знаков)",
       hint="mean(mtcars$mpg)",
       code='mean(mtcars$mpg)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 20.09) < 0.05),
  
  list(id="s2", emoji="2", title="ГИСТОГРАММА mpg",
       desc="Посмотри на гистограмму. В каком диапазоне mpg больше всего машин? Введи нижнюю границу бина с максимумом (округли до целого).",
       hint="Смотри на самый высокий столбик. Он около 16.",
       code='hist(mtcars$mpg, breaks=10, col="skyblue", main="Гистограмма mpg")',
       plot=function() ggplot(mtcars, aes(x=mpg)) +
         geom_histogram(bins=10, fill="#ffd0e7", color="#ff9ecf", linewidth=0.7) +
         labs(title="Гистограмма mpg", x="mpg", y="Частота") +
         theme_pastel(),
       check=function(s) {
         v <- suppressWarnings(as.numeric(s))
         !is.na(v) && v >= 15 && v <= 17
       }),
  
  list(id="s3", emoji="3", title="Корреляция",
       desc="Коэффициент корреляции Пирсона между mpg и wt (округли до 2 знаков)",
       hint="cor(mtcars$mpg, mtcars$wt) - отрицательное число",
       code='cor(mtcars$mpg, mtcars$wt)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) + 0.87) < 0.05),
  
  list(id="s4", emoji="4", title="ГИСТОГРАММА hp",
       desc="Сколько машин имеют мощность (hp) от 150 до 200? Посчитай столбики.",
       hint="Сумма высот столбиков в этом диапазоне примерно 8.",
       code='hist(mtcars$hp, breaks=8, col="salmon")\nsum(mtcars$hp >= 150 & mtcars$hp <= 200)',
       plot=function() ggplot(mtcars, aes(x=hp)) +
         geom_histogram(bins=8, fill="#c7e4ff", color="#8bbfff", linewidth=0.7) +
         labs(title="Гистограмма hp", x="hp", y="Частота") +
         theme_pastel(),
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 8) < 1.5),
  
  list(id="s5", emoji="5", title="t-тест Стьюдента",
       desc="Сравни mpg для am=0 и am=1. Какое p-value? Округли до 3 знаков.",
       hint="t.test(mpg ~ am, data = mtcars)$p.value",
       code='t.test(mpg ~ am, data = mtcars)$p.value',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 0.001) < 0.005),
  
  list(id="s6", emoji="6", title="Линейная регрессия",
       desc="Модель mpg ~ wt + hp. R^2? Округли до 2 знаков.",
       hint="summary(lm(mpg ~ wt + hp, data = mtcars))$r.squared",
       code='summary(lm(mpg ~ wt + hp, data = mtcars))$r.squared',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 0.83) < 0.05),
  
  list(id="s7", emoji="7", title="ГИСТОГРАММА по группам",
       desc="Гистограмма mpg по числу цилиндров. У какой группы пик САМЫЙ ВЫСОКИЙ? Введи число цилиндров (4, 6 или 8).",
       hint="Смотри на самый высокий столбик — это машины с 4 цилиндрами.",
       code='ggplot(mtcars, aes(x=mpg, fill=factor(cyl))) +\n  geom_histogram(alpha=0.7, position="identity", bins=8)',
       plot=function() ggplot(mtcars, aes(x=mpg, fill=factor(cyl))) +
         geom_histogram(alpha=0.8, position="identity", bins=8, color="white", linewidth=0.4) +
         scale_fill_manual(values=c("#ffc2dd","#b8d9ff","#e0d0ff")) +
         labs(title="mpg по цилиндрам", fill="Цилиндры", x="mpg", y="Частота") +
         theme_pastel(),
       check=function(s) {
         v <- suppressWarnings(as.numeric(s))
         !is.na(v) && v == 4
       }),
  
  list(id="s8", emoji="8", title="ANOVA",
       desc="ANOVA для mpg по cyl. F-значение? Округли до 1 знака.",
       hint="summary(aov(mpg ~ factor(cyl), data = mtcars))[[1]]$`F value`[1]",
       code='summary(aov(mpg ~ factor(cyl), data = mtcars))[[1]]$"F value"[1]',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 39.7) < 2),
  
  list(id="s9", emoji="9", title="Тест Шапиро-Уилка",
       desc="Нормально ли распределена mpg? Ответь 'yes' если p>0.05, иначе 'no'.",
       hint="shapiro.test(mtcars$mpg)$p.value",
       code='shapiro.test(mtcars$mpg)$p.value',
       check=function(s) tolower(trimws(s)) == "yes"),
  
  list(id="s10",emoji="10", title="ГИСТОГРАММА (5 бинов)",
       desc="Гистограмма mpg с 5 бинами. В каком бине больше всего машин? Введи нижнюю границу бина (целое).",
       hint="Диапазон mpg примерно 10-34. Пять бинов шириной ~5.",
       code='hist(mtcars$mpg, breaks=5, col="lightgreen")',
       plot=function() ggplot(mtcars, aes(x=mpg)) +
         geom_histogram(bins=5, fill="#e0d0ff", color="#b8a8ff", linewidth=0.8) +
         labs(title="Гистограмма mpg (5 бинов)", x="mpg", y="Частота") +
         theme_pastel(),
       check=function(s) {
         v <- suppressWarnings(as.numeric(s))
         !is.na(v) && v >= 15 && v <= 20
       })
)

# ============================================================
# 3. ФИНАНСЫ
# ============================================================
fin_tasks <- list(
  list(id="f1", emoji="1", title="Сложный процент",
       desc="100 000 руб. под 12% годовых на 5 лет. Итоговая сумма? Округли до целого.",
       hint="P * (1 + r)^n = 100000 * 1.12^5",
       code='100000 * (1.12)^5',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 176234) < 300),
  list(id="f2", emoji="2", title="NPV проекта",
       desc="Потоки: -1000, 300, 400, 500, 300. Ставка 10%. NPV? Округли до 1 знака.",
       hint="sum(cf / (1+r)^(0:4))",
       code='cf <- c(-1000, 300, 400, 500, 300)\nr <- 0.10\nsum(cf / (1+r)^(0:4))',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 145.1) < 5),
  list(id="f3", emoji="3", title="IRR",
       desc="Для тех же потоков найди IRR (в %). Округли до целого.",
       hint="uniroot(function(r) sum(cf/(1+r)^(0:4)), c(0,1))$root * 100",
       code='cf <- c(-1000, 300, 400, 500, 300)\nf <- function(r) sum(cf/(1+r)^(0:4))\nuniroot(f, c(0,1))$root * 100',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 17) < 3),
  list(id="f4", emoji="4", title="Аннуитетный платеж",
       desc="Кредит 500 000 руб., 15% годовых, 36 мес. Ежемесячный платеж? Округли до целого.",
       hint="r = 0.15/12; P*r/(1-(1+r)^-n)",
       code='P<-500000; r<-0.15/12; n<-36\nP*r/(1-(1+r)^-n)',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 17334) < 200),
  list(id="f5", emoji="5", title="Доходность акции",
       desc="Куплена за 100 руб., продана за 120 руб., дивиденды 5 руб. Доходность в %?",
       hint="(120 - 100 + 5) / 100 * 100",
       code='(120 - 100 + 5) / 100 * 100',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 25) < 0.5),
  list(id="f6", emoji="6", title="Волатильность",
       desc="Месячные доходности: 0.05, -0.02, 0.03, 0.07, -0.01, 0.04. Годовая волатильность в %? Округли до 1 знака.",
       hint="sd(r) * sqrt(12) * 100",
       code='r <- c(0.05,-0.02,0.03,0.07,-0.01,0.04)\nsd(r) * sqrt(12) * 100',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 11.6) < 1),
  list(id="f7", emoji="7", title="Инфляция",
       desc="100 000 руб. через 3 года при инфляции 8%. Реальная стоимость? Округли до целого.",
       hint="100000 / 1.08^3",
       code='100000 / (1.08)^3',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 79383) < 300),
  list(id="f8", emoji="8", title="Срок окупаемости",
       desc="Инвестиции -1000, потоки 300, 400, 500, 300. Через сколько лет окупится? (целое)",
       hint="cumsum(cf) - кумулятивная сумма",
       code='cf <- c(-1000, 300, 400, 500, 300)\nwhich(cumsum(cf) >= 0)[1] - 1',
       check=function(s) {
         v <- suppressWarnings(as.numeric(s))
         !is.na(v) && v == 3
       }),
  list(id="f9", emoji="9", title="Портфель",
       desc="60% в активе с доходностью 12% и 40% в активе с 8%. Ожидаемая доходность в %?",
       hint="0.6*12 + 0.4*8",
       code='sum(c(0.6, 0.4) * c(0.12, 0.08)) * 100',
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 10.4) < 0.2),
  list(id="f10",emoji="10", title="ГРАФИК роста капитала",
       desc="Рост 100 000 руб. под 10% за 10 лет. Сумма через 10 лет? Округли до целого.",
       hint="V = 100000 * 1.10^10",
       code='100000 * (1.10)^10',
       plot=function(){
         df <- data.frame(year=0:10, value=100000*1.10^(0:10))
         ggplot(df, aes(year, value)) +
           geom_area(fill="#c7e4ff", alpha=0.5) +
           geom_line(color="#ff9ecf", linewidth=1.5) +
           geom_point(color="#b8a8ff", size=4) +
           labs(title="Рост капитала 10%/год", x="Год", y="Стоимость, руб.") +
           theme_pastel()
       },
       check=function(s) abs(suppressWarnings(as.numeric(s)) - 259374) < 500)
)

# ============================================================
# UI
# ============================================================
ui <- fluidPage(
  tags$head(
    tags$style(HTML(custom_css)),
    tags$meta(charset = "UTF-8")
  ),
  
  tags$div(
    class = "heart", "\u2764",
    tags$div(class = "heart", "\u2764"),
    tags$div(class = "heart", "\u2728"),
    tags$div(class = "heart", "\u2740"),
    tags$div(class = "heart", "\u2b50")
  ),
  
  div(class = "app-title", "R Tasks Studio"),
  div(class = "app-subtitle",
      "Реши все задачи сама! Введи ответ и нажми Проверить"),
  div(class = "deco", "\u2728"),
  
  sidebarLayout(
    sidebarPanel(
      div(class = "sidebar-box",
          h4("Выбери раздел"),
          radioButtons("section", NULL,
                       choices = c(
                         "Математические задачи"  = "math",
                         "Анализ данных"           = "stats",
                         "Финансовые задачи"       = "fin"
                       ),
                       selected = "math"
          ),
          div(class = "score-badge",
              uiOutput("score_ui")
          )
      ),
      width = 3
    ),
    mainPanel(
      width = 9,
      conditionalPanel("input.section == 'math'",
                       div(class = "section-title", "Математические задачи"),
                       lapply(math_tasks, function(t)
                         task_ui(t$id, t$title, t$desc, t$code, t$emoji, hint = t$hint))
      ),
      conditionalPanel("input.section == 'stats'",
                       div(class = "section-title", "Анализ данных и статистика"),
                       lapply(stat_tasks, function(t)
                         task_ui(t$id, t$title, t$desc, t$code, t$emoji,
                                 plot_output = TRUE, hint = t$hint))
      ),
      conditionalPanel("input.section == 'fin'",
                       div(class = "section-title", "Финансовые задачи"),
                       lapply(fin_tasks, function(t)
                         task_ui(t$id, t$title, t$desc, t$code, t$emoji,
                                 plot_output = TRUE, hint = t$hint))
      )
    )
  )
)

# ============================================================
# SERVER
# ============================================================
server <- function(input, output, session) {
  score <- reactiveVal(0)
  solved <- reactiveVal(character(0))
  
  output$score_ui <- renderUI({
    HTML(sprintf("Решено: <b>%d</b> / 30", score()))
  })
  
  all_tasks <- c(math_tasks, stat_tasks, fin_tasks)
  
  for (i in seq_along(all_tasks)) {
    local({
      task <- all_tasks[[i]]
      id <- task$id
      
      if (!is.null(task$plot)) {
        output[[paste0(id, "-plot")]] <- renderPlot({ task$plot() })
      }
      
      observeEvent(input[[paste0(id, "-check")]], {
        ans <- input[[paste0(id, "-answer")]]
        
        if (is.null(ans) || trimws(ans) == "") {
          output[[paste0(id, "-feedback")]] <- renderUI({
            div(class = "feedback-empty", "Ты не ввела ответ. Попробуй ещё разок!")
          })
          return()
        }
        
        ok <- tryCatch(task$check(ans), error = function(e) FALSE)
        
        if (isTRUE(ok)) {
          if (!(id %in% solved())) {
            solved(c(solved(), id))
            score(length(solved()))
          }
          output[[paste0(id, "-feedback")]] <- renderUI({
            div(class = "feedback-ok", "Правильно! Ты умница!")
          })
        } else {
          output[[paste0(id, "-feedback")]] <- renderUI({
            div(class = "feedback-no", "Не совсем. Попробуй ещё раз или посмотри подсказку.")
          })
        }
      })
    })
  }
}

shinyApp(ui, server)