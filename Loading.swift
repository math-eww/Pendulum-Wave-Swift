//
//  Loading.swift
//  Matt Saunders
//
//  Created by Matt Saunders on 2015-06-24.
//  Copyright (c) 2015 Matt Saunders. All rights reserved.
//

import Foundation
import UIKit
import Darwin
import QuartzCore

class Loading {
    
    var numBalls = 20           // Number of balls
    var ballRadius = 5          // Size of balls
    var ballSpace = 5           // Space between balls?
    var ballYTravel = 100       // How far up and down the balls go
    var animationPosX = 50      // X position of entire animation
    
    var ballColor = UIColor.blackColor().CGColor    // Color of balls
    
    var timeStep = 0            // Affects starting position of balls
    
    // UI stuff
    let containerView = UIView()
    var circlesArr = Array<CAShapeLayer>()
    
    // Animation updater display link
    var updater = CADisplayLink()
    var isAnimating = false
    
    
    // Builds one ball
    func drawCircle() -> CAShapeLayer {
        var circle = CAShapeLayer()
        var path = UIBezierPath()
        path.addArcWithCenter(CGPoint(x: 30, y: 30), radius: CGFloat(ballRadius), startAngle: 0, endAngle: 180, clockwise: true)
        circle.frame = CGRect(x: 15, y: 15, width: ballRadius, height: ballRadius)
        circle.path = path.CGPath
        circle.strokeColor = ballColor
        circle.fillColor = ballColor
        circle.lineWidth = 1.0
        return circle
    }
    
    // Initializes all balls
    func setupCircles() {
        for var i=0; i<numBalls; i++ {
            circlesArr.append(drawCircle())
            containerView.layer.addSublayer(circlesArr[i])
        }
    }
    
    // Animates the balls
    @objc func animateBalls(sender: CADisplayLink) {
        for var i=0; i<numBalls; i++ {
            //Move balls to location getY and appropriate x pos
            circlesArr[i].frame = CGRect(x: animationPosX + ballSpace * i, y: getY(i, t: timeStep), width: ballRadius, height: ballRadius)
        }
        timeStep++
    }
    
    // Returns the Y position for a given ball at a given time
    func getY(i:Int, t:Int) -> Int {
        return Int(Float(ballYTravel)/2 * (1 + sin((Float(timeStep) * (Float(i)/500 + 0.02)))))
    }
    
    // Builds and returns the entire view
    func setupLoading() -> UIView {
        // Initialize all balls and add to view
        setupCircles()
        // Set containerView size to fit balls
        let width = animationPosX + (numBalls * ballRadius) + (ballSpace * (numBalls - 1))
        containerView.bounds = CGRectMake(0, 0, CGFloat(width), CGFloat(ballYTravel) * 1.5)
        // Setup animation caller and pause it
        self.updater = CADisplayLink(target: self, selector: "animateBalls:")
        self.updater.frameInterval = 1
        self.updater.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        self.updater.paused = true
        // Return the containing view
        return containerView
    }
    
    func startLoad() {
        self.isAnimating = true
        self.updater.paused = false
        /*
        let positionAnimation = CABasicAnimation
        let animationGroup = CAAnimationGroup()
        animationGroup.repeatCount = Float.infinity
        animationGroup.duration = 2.0
        animationGroup.beginTime = [borderShapeLayer convertTime:CACurrentMediaTime() fromLayer:nil] + ring
        animationGroup.timingFunction = [CAMediaTimingFunction functionWithControlPoints:.3:0:1:1]
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        */
        /*
        UIView.animateWithDuration(0.1, delay: 0, options: .Repeat, animations: {
            self.animateBalls()
        }, completion: nil)
        */
    }
    
    func stopLoad() {
        self.isAnimating = false
        self.updater.paused = true
    }
    
    //Reference code from inspiration
    /*
    private const NUM_BALL:int = 24;
    private var loadingBall:Vector.<Shape> = new Vector.<Shape>(NUM_BALL);
    private var timeStep:int = 0;
    private const BALL_HEIGHT:int = 40;
    
    public function animateBalls(e:Event):void
    {
    for (var i:int = 0; i < NUM_BALL; i++ )
    {
    loadingBall[i].graphics.clear();
    loadingBall[i].graphics.beginFill(0x0B5F95);
    loadingBall[i].graphics.drawCircle(455+5*i,getY(i,timeStep),2);
    }
    timeStep++;
    }
    
    public function getY(i:int, t:int):int
    {
    return 260 + BALL_HEIGHT/2 * (1 + Math.sin((timeStep * (i/500 + 0.02)) % 2*Math.PI));
    }
    */
    
    
    /*
    var numBalls = 24; // numb balls
    var timeStep = 0;
    var ballYTravel = 100;
    var ballRadius = 5;
    var ballSpace = 20;
    
    var animationPosX = 100;
    
    function clearCanvas() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
    
    function drawBall(x, y, radius) {
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.stroke();
    }
    
    function animateBalls() {
    clearCanvas();
    
    for (var i = 0; i < numBalls; i++) {
    drawBall(animationPosX + ballSpace * i, getY(i, timeStep), ballRadius);
    }
    
    timeStep++;
    requestAnimationFrame(animateBalls);
    }
    
    function getY(i, timeStep) {
    return 200 + ballYTravel / 2 * (Math.sin(timeStep * (i / 200 + 0.08)));
    }
    
    animateBalls();
    */
    
    // (deprecated) Hides all balls
    /*
    func clearContainerView() {
    var containerViewSubviewsArr = containerView.subviews
    for view in containerViewSubviewsArr {
    view.layer.hidden = true
    }
    }
    */
}