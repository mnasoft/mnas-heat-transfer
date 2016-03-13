;;;; mnas-heat-transfer-data-zadacha.lisp

(in-package #:mnas-heat-transfer)

;;; "mnas-heat-transfer" goes here. Hacks and glory await!

(defparameter *k-w* 11.5 "Ширина контейнера")

(defparameter *k-l* 5.80 "Длина контейнера")

(defparameter *k-h* 5.7 "Высота контейнера")

(defparameter *g* 9.8065  "Ускорение свободного падения на поверхности Земли, м/с^2")

(defparameter *part* 0.35 "Часть тепла, отводящегося через крышку")

(defparameter *d-kr* 3.5  "Диаметр крышки, м")

(defparameter *δ-kr-s* 0.3  "Толщина слоя стали крышки, м")

(defparameter *λ-kr-s* 42  "Теплопроводность слоя стали крышки, Вт/(м*К)")

(defparameter *δ-kr-p* 0.05 "Толщина слоя покрытия крышки, Вт/(м*К)")

(defparameter *λ-kr-p* 82  "Теплопроводность слоя покрытия крышки, Вт/(м*К)")

(defparameter *air* (make-instance 'idelchik:gas :name "Воздух"))

(defparameter *p-w-out* (make-instance 'parametrised :tempreche (+ 273.15 100.0)) "Температура наружной стороны стенки контейнера, К")

(defparameter *p-l-out* (make-instance 'parametrised :tempreche (+ 273.15 38.0)) "Температура жидкости на удалении стороны стенки, К")

(defparameter *p-mid* (make-instance 'parametrised :tempreche (/ (+ (tempreche *p-w-out*) (tempreche *p-l-out*)) 2))
  "Среднее арифметическое между:
температурой наружной стороны стенки контейнера и 
температурой жидкости на удалении стороны стенки.")

(β *air* *p-w-out*)

(Gr *air* *p-w-out* *p-l-out* *d-kr* *g*)

(Pr-air (+ 273.15 22.5 ))

(Nu-8-9   *air* *p-w-out* *p-l-out* *d-kr* *g*)

(α-Nu-λ-l *air* *p-w-out* *p-l-out* *d-kr* *g*)

(setf (tempreche *p-w-out*) (+ 95 273.15))

(/ (Q *air* *p-w-out* *p-l-out* *d-kr* *g* (* *d-kr* *d-kr* 0.25 pi)) *part*)



(mapcar
 #'(lambda (el)
     (setf (tempreche *p-w-out*) (+ el 273.15))
     (let
	 ((Q_out (/ (Q *air* *p-w-out* *p-l-out* *d-kr* *g* (* *d-kr* *d-kr* 0.25 pi)) *part*))
	  (α_out (α-Nu-λ-l *air* *p-w-out* *p-l-out* *d-kr* *g*)))
       (format t "~%~A ~A ~A ~A ~A" (* Q_out 0.001) el (+ el 2.5) (+ el -2.5) α_out)
       (list  Q_out el)))
 '(40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135))

(/ (* *d-kr* *d-kr* 0.25 pi)
   (+ (* *k-w* *k-h* 0.5 2.0 ) (* *k-l* *k-h*) (* *k-w* *k-h* 0.5 2.0) ) )

(mapcar
 #'(lambda (el)
     (let*
	 ((p-w (make-instance 'parametrised :tempreche (+ el 273.15)))
	  (f (* *d-kr* *d-kr* 0.25 pi))
	  (q-pass (Q *air* p-w *p-l-out* *d-kr* *g* f))
	  (t-in-s (- el (* (/ q-pass f) (/ *δ-kr-s*  *λ-kr-s*))))
	  (t-in-p (- el (* (/ q-pass f)
			      (+
			       (/ *δ-kr-s*  *λ-kr-s*)
			       (/ *δ-kr-p* *λ-kr-p*)))))
	  )
       (list q-pass f   t-in-p t-in-s el)))
 '(40 45 50 55 60 65 70 75 80 85 90 95 100))
