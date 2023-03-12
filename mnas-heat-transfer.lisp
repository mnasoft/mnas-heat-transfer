;;;; mnas-heat-transfer.lisp

(in-package :mnas-heat-transfer)

;;; "mnas-heat-transfer" goes here. Hacks and glory await!

(defun Nu (α l λ) (/ (* α l) λ))

(defgeneric Gr (liquid param-wall param-liquid dimenion acceleration-of-gravity)
  (:documentation "Число Грасгофа")
  )

(defmethod Gr ( (agas gas) (p-w parametrised) (p-l parametrised) dimension acceleration-of-gravity)
  (let ((p-mid (make-instance 'parametrised :tempreche (/ (+ (tempreche p-w) (tempreche p-l)) 2))))
    (/ (* (expt dimension 3) acceleration-of-gravity (β agas p-mid) (- (tempreche p-w) (tempreche p-l)) )
       (* (expt (ν p-mid agas) 2)))))

(defgeneric β (liquid param)
  (:documentation "Возвращает коэффициент температурного расширения жидкости liquid при параметрах жидкости param"))

(defmethod β ((agas gas) (param parametrised))
  (/ 1 (tempreche param)))

(defgeneric Nu-8-9 (liquid param-w param-liquid dimension acceleration-of-gravity)
  (:documentation
   "Число Нуссельта для горизонтальной пластины")
  )

(defmethod Nu-8-9 ((agas gas) (p-w parametrised) (p-l parametrised) dimension  acceleration-of-gravity)
  (let*
      ((p-mid (make-instance 'parametrised :tempreche (/ (+ (tempreche p-w) (tempreche p-l)) 2)))
       (Gr-mid (Gr agas p-w p-l dimension  acceleration-of-gravity))
       (Pr-mid (Pr-air (tempreche p-mid))))
    (values
     (cond
       ((<= 1e3 (* Gr-mid Pr-mid) 1e9) (* 0.71  (expt (* Gr-mid Pr-mid) 0.25)))
       ((>= (* Gr-mid Pr-mid) 1e9 )    (* 0.162 (expt (* Gr-mid Pr-mid) 0.33))))
     (format nil "p-mid=~A Gr-mid=~A Pr-mid=~A" p-mid Gr-mid Pr-mid)
     (- (tempreche p-w) 273.15)
     (- (tempreche p-l) 273.15)
     )))

(defgeneric α-Nu-λ-l (liquid p-wall p-liquid dimension acceleration-of-gravity)
  (:documentation
   "Коэффициент теплоотдачи"))

(defmethod α-Nu-λ-l ((agas gas) (p-w parametrised) (p-l parametrised) dimension  acceleration-of-gravity)
  (/
   (* (Nu-8-9 agas  p-w p-l dimension acceleration-of-gravity)
      (λ-air (/ (+ (tempreche p-w) (tempreche p-l) ) 2 )))
   dimension))

(defgeneric Q (liquid p-wall p-liquid dimension acceleration-of-gravity area)
  (:documentation "Определяет коичество тепла переданное с пластины")
  )

(defmethod Q ((agas gas) (p-w parametrised) (p-l parametrised) dimension  acceleration-of-gravity area)
  (* (α-Nu-λ-l agas p-w p-l dimension acceleration-of-gravity)
     (- (tempreche p-w) (tempreche p-l)  )
     area))

