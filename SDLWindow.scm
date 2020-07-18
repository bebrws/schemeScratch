;; Compatible with both CHICKEN 4 and CHICKEN 5.
(cond-expand
 (chicken-4 (use (prefix sdl2 "sdl2:")))
 (chicken-5 (import (prefix sdl2 "sdl2:"))))

(sdl2:set-main-ready!)
(sdl2:init! '(video))
(define window (sdl2:create-window! "Hello, World!" 0 0 600 400))
(define renderer (sdl2:create-renderer! window -1 '(software)))

(sdl2:fill-rect! (sdl2:window-surface window)
                 #f
                 (sdl2:make-color 0 128 255))
(sdl2:update-window-surface! window)

(define mcolor (sdl2:make-color 0 100 200 200))

(sdl2:render-draw-color-set! renderer mcolor)
(sdl2:render-draw-point! renderer 10 10)
;; (render-clear! renderer)

(define (main)
		(if (not (sdl2:quit-requested?))
			(main)
			#f))

(main)
(sdl2:quit!)


