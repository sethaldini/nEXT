;;; window.lisp --- commands for managing windows

(in-package :next)

(define-command delete-window ()
  "Delete the currently active window."
  (let ((active-window (rpc-window-active))
        (window-count (hash-table-count (windows *interface*))))
    (cond ((and active-window (> window-count 1))
           (rpc-window-delete active-window))
          (active-window
           (echo "Can't delete sole window.")))))

(define-command make-window (&optional buffer)
  "Create a new window."
  (let ((window (rpc-window-make))
        (buffer (or buffer (make-buffer))))
    (window-set-active-buffer window buffer)
    (values window buffer)))

(define-deprecated-command new-window ()
  "Deprecated by `make-window'."
  (make-window))
