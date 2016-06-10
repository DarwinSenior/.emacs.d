(cond
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_UK")
  (setq ispell-local-dictionary-alist
    '(("en_UK" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_UK") nil utf-8)))))
