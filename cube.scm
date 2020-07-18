;; A perfect little Rotating Cube
;; Copyright
;; Bradley Barrows 2020
;; bradebarrowsdev@gmail.com
;;
;;
;; Compatible with both CHICKEN 4 and CHICKEN 5.
(cond-expand (chicken-4 (use (prefix sdl2 "sdl2:")))
             (chicken-5 (import (prefix sdl2 "sdl2:")))
             (use string))
			 
(sdl2:set-main-ready!)
(sdl2:init! '(video))
(define window (sdl2:create-window! "Rotating Cube" 0 0 300 300))
(define renderer (sdl2:create-renderer! window -1 '(software)))

;; (render-clear! renderer)
(define rcolor (sdl2:make-color 255 8 5 125))
(define bcolor (sdl2:make-color 20 30 150 125))
(define gcolor (sdl2:make-color 20 180 50 125))
(define bkcolor (sdl2:make-color 180 180 180 125))


(define fatpixel
        (lambda (x y)
         (sdl2:render-fill-rect! renderer (sdl2:make-rect x y 5 5))))


(define nodes
 `((-1 -1 -1) (-1 -1 1) (-1 1 -1) (-1 1 1) (1 -1 -1) (1 -1 1) (1 1 -1) (1 1 1)))
(define edges
 `((0 1) (1 3) (3 2) (2 0) (4 5) (5 7) (7 6) (6 4) (0 4) (1 5) (2 6) (3 7)))


(define scale
 (lambda (f0 f1 f2)
  (map
   (lambda (n)
    `(,(* (list-ref n 0) f0) ,(* (list-ref n 1) f1) ,(* (list-ref n 2) f2)))
   nodes)))


(define rotateCube
 (lambda (ax ay)
  (map (lambda (n)
        (let ((sinx (sin ax))
              (cosx (cos ax))
              (siny (sin ay))
              (cosy (cos ay)))
         (let ((yOrig (list-ref n 1))
               (xOrig (list-ref n 0))
               (newX (- (* (list-ref n 0) cosx) (* (list-ref n 2) sinx))))
          (let ((tempZ (+ (* (list-ref n 2) cosx) (* xOrig sinx))))
           (let ((newY (- (* yOrig cosy) (* tempZ siny)))
                 (newZ (+ (* tempZ cosy) (* yOrig siny))))            
            `(,newX ,newY ,newZ)
			)))))
       nodes)))
(define (foreach oper lst)
 (cond
  ((empty? lst)
   0)
  (else
   ((oper (car lst)) (foreach oper (cdr lst))))))

(define (draw)
 (sdl2:render-clear! renderer)
 (sdl2:render-draw-color-set! renderer bcolor)
 (sdl2:render-fill-rect! renderer (sdl2:make-rect 0 0 300 300))

 (sdl2:render-draw-color-set! renderer gcolor)
 (drawCube)

 (sdl2:render-present! renderer)
)

(define (drawCube)
 (map (lambda (e)
       (let ((p1 (list-ref nodes (list-ref e 0)))
             (p2 (list-ref nodes (list-ref e 1))))
        (let ((x1 (round (list-ref p1 0)))
              (y1 (round (list-ref p1 1)))
              (x2 (round (list-ref p2 0)))
              (y2 (round (list-ref p2 1))))
         (sdl2:render-draw-line! renderer (+ x1 140) ( + y1 140) (+ x2 140) (+ y2 140))
		)))
      edges))

(define (main)
 (sdl2:delay! 50)
 (set! nodes (rotateCube (/ 3.14 180) 0))
 (draw)
 (if (not (sdl2:quit-requested?))
  (main)
  #f
 )
)

(sdl2:render-draw-color-set! renderer rcolor)
(set! nodes (scale 50 50 50))
(set! nodes (rotateCube (/ 3.14 4) (atan (sqrt 2))))
(main)
(sdl2:quit!)
