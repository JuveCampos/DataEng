library(mailR)

send.mail(from = "jcampos@colmex.mx",
          to = "juvenal.campos@cide.edu",
          subject = "Mail de prueba",
          body = "Este es un mail de prueba",
          authenticate = TRUE,
          smtp = list(host.name = "smtp.office365.com", port = 587,
                      user.name = "jcampos@colmex.mx", passwd = "#######", tls = TRUE))
