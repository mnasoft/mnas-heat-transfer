;;;; mnas-heat-transfer-data.lisp

(in-package #:mnas-heat-transfer)

;;; "mnas-heat-transfer" goes here. Hacks and glory await!

(defparameter *air-prop*
  '((-50 1.584 1.013 2.04 14.6 9.23  12.7 0.728)
    (-40 1.515 1.013 2.12 15.2 10.04 13.2 0.728)
    (-30 1.453 1.013 2.20 15.7 10.80 14.9 0.723)
    (-20 1.395 1.009 2.28 16.2 12.79 16.2 0.716)
    (-10 1.342 1.009 2.36 16.7 12.43 17.4 0.712)
    
    (0   1.293 1.005 2.44 17.2 13.28 18.8 0.707)
    (10  1.247 1.005 2.51 17.6 14.16 20.0 0.705)
    (20  1.205 1.005 2.59 18.1 15.06 21.4 0.703)
    (30  1.165 1.005 2.67 18.6 16.00 22.9 0.701)
    (40  1.128 1.005 2.76 19.1 16.96 24.3 0.699)
    
    (50  1.093 1.005 2.83 19.6 17.95 25.7 0.698)
    (60  1.060 1.005 2.90 20.1 18.97 26.2 0.696)
    (70  1.029 1.009 2.96 20.6 20.02 28.6 0.694)
    (80  1.000 1.009 3.05 21.1 21.09 30.2 0.692)
    (90  0.972 1.009 3.13 21.5 22.10 31.9 0.690)
    
    (100 0.946 1.009 3.21 21.9 23.13 33.6 0.688)
    (120 0.898 1.009 3.34 22.8 25.45 36.8 0.686)
    (140 0.854 1.013 3.49 23.7 27.80 40.3 0.684)
    (160 0.815 1.017 3.64 24.5 30.09 43.9 0.682)
    (180 0.779 1.022 3.78 25.3 32.49 47.5 0.681)
    
    (200 0.746 1.026 3.93 26.0 34.85 51.4 0.680)
    (250 0.674 1.038 4.27 27.4 40.61 61.0 0.677)
    (300 0.615 1.047 4.60 29.7 48.33 71.6 0.674)
    (350 0.566 1.059 4.91 31.4 55.46 81.9 0.676)
    (400 0.524 1.068 5.21 33.0 63.09 93.1 0.678)

    (500 0.456 1.093 5.74 36.2 79.38 115.3 0.687)
    (600 0.404 1.114 6.22 39.1 96.89 138.3 0.699)
    (700 0.362 1.135 6.72 41.8 115.4 163.4 0.706)
    (800 0.329 1.156 7.18 44.3 134.8 188.8 0.713)
    (900 0.301 1.172 7.63 46.7 155.1 216.2 0.717)
    
    (1000 0.277 1.185 8.07 49.0 177.1 245.9 0.719)
    (1100 0.257 1.197 8.50 51.2 199.3 276.2 0.722)
    (1200 0.239 1.210 9.15 53.5 233.7 316.5 0.724))
   "Физические свойства сухого воздуха при атмосферном давлении в зависимости от температуры
t[°C] ρ[кг/м3] cp[кДж/(кг*К)] λ*10^2[Вт/(м*К)] μ*10^6[Па*с] ν*10^6[м2/с] a[м2/с] Pr
t  - температура воздуха;
ρ  - плотность воздуха в кг/м3;
cp - удельная (массовая) теплоемкость, кДж/(кг·град);
λ  - теплопроводность воздуха, Вт/(м·град);
μ  - вязкость динамическая, Па·с;
ν  - вязкость кинематическая, м2/с;
a  - коэффициент температуропроводности, м2/с;
Pr - число Прандтля.
Михеев М.А., Михеева И.М. Основы теплопередачи. 
http://thermalinfo.ru/load/teplophizika_i_teplotehnika/mikheev_m_a_mikheeva_i_m_osnovy_teploperedachi/1-1-0-8")

(defparameter *air-Pr*
  (mapcar #'(lambda (el) (list (+ 273.15 (first el)) (eighth el)))
	  *air-prop*)
  "Значения числа Прандтля для сухого воздуха в зависимости от температуры в Кельвинах"  
  )

(defparameter *air-λ*
  (mapcar #'(lambda (el) (list (+ 273.15 (first el)) (/ (fourth el) 100)))
	  *air-prop*)
  "Значения коэффициента теплопроводности для сухого воздуха в зависимости от температуры в Кельвинах Вт/(м·град)"  
  )

(defun Pr-air(tempreche[K]) (table_aproximate tempreche[K] *air-Pr*))

(defun λ-air(tempreche[K]) (table_aproximate tempreche[K] *air-λ*))