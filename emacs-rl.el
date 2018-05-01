(defvar erl/main-buffer-name "*emacs-rl*")

(defun erl/get-main-buffer ()
  "Returns a reference to the main game buffer"
  (if-let (main-buffer (get-buffer erl/main-buffer-name))
      main-buffer
    (let ((main-buffer (generate-new-buffer erl/main-buffer-name)))
      (with-current-buffer main-buffer
	(read-only-mode)
	main-buffer))))

(defun erl/cell-string (cell)
  "Returns the string that represents the cell on the map"
  (let ((type (plist-get cell :type)))
    (cond
     ((eq type :floor) ".")
     ((eq type :wall) "#"))))

(defun erl/map-string (map-data)
  "Return the string that represents the map"
  (mapconcat
   (lambda (row)
     (mapconcat #'erl/cell-string row ""))
   map-data
   "\n"))

(defun erl/render-map (map-data)
  "Renders a dungeon map

   The map is a list of rows, where each row is a list
   of plists representing the data for a cell"
  (with-current-buffer (erl/get-main-buffer)
    (let ((map-str (erl/map-string map-data))
	  (inhibit-read-only t))
      (erase-buffer)
      (insert map-str))))
