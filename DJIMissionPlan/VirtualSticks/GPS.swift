//
//  GPS.swift

import Darwin



class GPS {
 
    var waypointList : Array = [[Double]]()
    var radiusWPList: Array = [[Double]]()
    
    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
    
    func GPS(){
        
    }
    //MARK:- Yaw +/- 180°
    func yawControl(yaw: Float) -> Float {
        if yaw == 180 {
            return 180
        } else {
            return Float((Int(yaw) + 540) % 360 - 180)
        }
    }
       
   //MARK:- GPS Bearing
   func getBearingBetweenTwoPoints(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
       
       let lat1 = self.degreesToRadians(degrees: point1.latitude)
       let lon1 = self.degreesToRadians(degrees: point1.longitude)
       
       let lat2 = self.degreesToRadians(degrees: point2.latitude)
       let lon2 = self.degreesToRadians(degrees: point2.longitude)
       
       // print("Pos1 \(point1.coordinate.longitude) \(point1.coordinate.latitude) Pos2 \(point2.coordinate.longitude) \(point2.coordinate.latitude)")
       
       let dLon = lon2 - lon1
       
       let y = sin(dLon) * cos(lat2)
       let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
       let radiansBearing = atan2(y, x)
       
       // print("Bearing \(radiansToDegrees(radians: radiansBearing))")
       
       return self.radiansToDegrees(radians: radiansBearing)
   }
   
   //MARK:- GPS Distance
   func getDistanceBetweenTwoPoints(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
       
       let lat1 = self.degreesToRadians(degrees: point1.latitude)
       let lon1 = self.degreesToRadians(degrees: point1.longitude)
       
       let lat2 = self.degreesToRadians(degrees: point2.latitude)
       let lon2 = self.degreesToRadians(degrees: point2.longitude)
       
       return acos( sin(lat1)*sin(lat2) + cos(lat1)*cos(lat2)*cos(lon2-lon1) ) * 6371000
       
   }
   
   //MARK:- GPS Lat
   func latm(latitude: Double, distance: Double, bearing: Float, radiusM: Double = 6371000) -> Double {
       let dr: Double = .pi / 180.0
       let rd: Double = 180.0 / .pi
       return asin(sin(latitude*dr) * cos(distance/radiusM) + cos(latitude*dr) * sin(distance/radiusM) * cos(Double(bearing)*dr)) * rd
   }
   
   //MARK:- GPS Lon
   func lonm(latitude: Double, longitude: Double, latitudeM: Double, distance: Double, bearing: Float, radiusM: Double = 6371000) -> Double {
       let dr: Double = .pi / 180.0
       let rd: Double = 180.0 / .pi
       return longitude + atan2(sin(Double(bearing)*dr) * sin(distance/radiusM) * cos(latitude*dr), cos(distance/radiusM) - sin(latitude*dr) * sin(latitudeM*dr)) * rd
   }
   
   //MARK:- GPS New Coordinate
   func newCoor(latitude: Double, longitude: Double, distance: Double, bearing: Float, radiusM: Double = 6371000) -> CLLocationCoordinate2D {
       let latitudeM: Double = self.latm(latitude: latitude, distance: distance, bearing: bearing, radiusM: radiusM)
       let longitudeM: Double = self.lonm(latitude: latitude, longitude: longitude, latitudeM: latitudeM, distance: distance, bearing: bearing, radiusM: radiusM)
       return CLLocationCoordinate2DMake(latitudeM, longitudeM)
   }
   
   //MARK:- GPS Near
   func near(yaw: Double, target: Double, tol: Double) -> Bool {
       if yaw - target <= tol && target - yaw <= tol {
           return true
       } else {
           return false
       }
   }
    
    //MARK:- GPS Coordinate String
    func coordinateString(_ latitude: Double,_ longitude: Double) -> String {
        var latSeconds = Int(latitude * 3600)
        let latDegrees = latSeconds / 3600
        latSeconds = abs(latSeconds % 3600)
        let latMinutes = latSeconds / 60
        latSeconds %= 60
        var longSeconds = Int(longitude * 3600)
        let longDegrees = longSeconds / 3600
        longSeconds = abs(longSeconds % 3600)
        let longMinutes = longSeconds / 60
        longSeconds %= 60
        return String(format:"%d°%d'%d\"%@ %d°%d'%d\"%@",
                      abs(latDegrees),
                      latMinutes,
                      latSeconds, latDegrees >= 0 ? "N" : "S",
                      abs(longDegrees),
                      longMinutes,
                      longSeconds,
                      longDegrees >= 0 ? "E" : "W" )
    }
    
    //MARK:- GPS Star Mission
    func star(radius: Double, points: Int, latitude: Double, longitude: Double, altitude: Double, pitch: Double) -> [[Double]] {
        var grid: Array = [[Double]]()
        var coor: CLLocationCoordinate2D
        var angle: Float = 0
        let R: Double = 6371000
        for z in 0..<points {
            angle = 360 / Float(points) * Float(z)
            angle = yawControl(yaw: angle)
            if z % 2 == 0 {
                coor = self.newCoor(latitude: latitude, longitude: longitude, distance: radius, bearing: angle, radiusM: R)
            } else {
                coor = self.newCoor(latitude: latitude, longitude: longitude, distance: radius/2, bearing: angle, radiusM: R)
            }
            
            if z == 0 {
                grid = [[Double(coor.latitude), Double(coor.longitude), altitude, pitch]]
            } else {
                grid.append([Double(coor.latitude), Double(coor.longitude), altitude, pitch])
            }
        }
        
        coor = self.newCoor(latitude: latitude, longitude: longitude, distance: radius, bearing: 0, radiusM: R)
        grid.append([Double(coor.latitude), Double(coor.longitude), altitude, pitch])
        grid.append([Double(latitude), Double(longitude), altitude, pitch])
        
        return grid
    }
    func getWayPoints() -> [[Double]]{
        var grid: Array = [[Double]]()
        for idx in 0 ..< waypointList.count{
            grid.append([Double(waypointList[idx][0]), Double(waypointList[idx][1]), Double(waypointList[idx][2]), -90])
        }
        return grid
    }
    
//    func toCartesian(longitude:Double, latitude:Double, altitude:Double) -> [Double]{
//        var res: Array = [Double]()
//        let R:Double=6378137.0
//        var x:Double = R*cos(longitude)*sin(latitude)
//        var y:Double = R*sin(longitude)*sin(latitude)
//        var z:Double = R*cos(latitude)
//        res.append(x)
//        res.append(y)
//        res.append(z)
//        return res
//    }
//    
//    func calcRadiusPath(radius:Double){
//        var idx:Int = 0
//        let PI:Double = 3.141592654
//        for wp in waypointList{
//            if (idx > 0 && idx < waypointList.count){
//                let cart0:Array = toCartesian(longitude: waypointList[idx-1][0], latitude: waypointList[idx-1][1], altitude: waypointList[idx-1][2])
//                let cart1:Array = toCartesian(longitude: waypointList[idx][0], latitude: waypointList[idx][1], altitude: waypointList[idx][2])
//                let cart2:Array = toCartesian(longitude: waypointList[idx+1][0], latitude: waypointList[idx+1][1], altitude: waypointList[idx+1][2])
//                var theta = atan2(cart0[0] - cart2[0], cart0[1] - cart2[1]) - atan2(cart1[0]-cart2[0], cart1[1]-cart2[1])
//                if theta > PI{
//                    theta -= 2 * PI
//                }
//                if theta < -PI{
//                    theta += 2 * PI
//                }
//                
//                theta = abs(theta * 180.0 / PI)
//                var s:Double = radius / tan(theta)
//                
//            }
//            idx ++
//        }
//    }
    ///
    ///
    ///
    func setWayPoint(latitude: Double, longitude: Double) -> Void{
//        var wp : sWayPoint
//        wp.dLat = latitude
//        wp.dLon = longitude
//        wp.dAlt = 70000
        waypointList.append([latitude, longitude, Double(70)])
    }
}
