;;;; mnas-heat-transfer.asd

(asdf:defsystem #:mnas-heat-transfer
  :description "Describe mnas-heat-transfer here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:varghaftik #:idelchik)
  :components ((:file "package")
               (:file "mnas-heat-transfer") ;
	       (:file "mnas-heat-transfer-data")
	       (:file "mnas-heat-transfer-zadacha" :depends-on ("mnas-heat-transfer" "mnas-heat-transfer-data"))
	       ))
