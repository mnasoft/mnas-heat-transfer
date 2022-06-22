;;;; mnas-heat-transfer.asd

(defsystem #:mnas-heat-transfer
  :description "Describe mnas-heat-transfer here"
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"  
  :serial t
  :depends-on (#:varghaftik #:idelchik)
  :components ((:file "package")
               (:file "mnas-heat-transfer") ;
	       (:file "mnas-heat-transfer-data")
	       (:file "mnas-heat-transfer-zadacha" :depends-on ("mnas-heat-transfer" "mnas-heat-transfer-data"))
	       ))
