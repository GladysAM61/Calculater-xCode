//
//  ContentView.swift
//  calculater
//
//  Created by StudentAM on 3/1/24.
//

import SwiftUI

struct ContentView: View {
    @State var Ans : Int = 0
    //    creating the variable thats going to have the numbers
    @State private var numsAndOperations: [[String]] = [
        ["AC","+/-", "%", "÷"],
        ["7","8", "9", "x"],
        ["4","5", "6", "-"],
        ["1","2", "3", "+"],
        ["0", "." , "="]
    ]
    @State var numsb4 : String = ""
    @State var numsafter : String = ""
    @State var userInput : String = "0"
    @State var answer : Int = 0
    @State var operation : String = ""
    @State var decimal : Double = 0.0
    
    
    
    var body: some View{
        //        zstack to change the background color black
        ZStack{
            Color.black.ignoresSafeArea()
            VStack{
                //                Text("0", text: $numsb4)
                Spacer()
                Text("\(userInput) ")
                //                .trailing to make the text appear in the right
                    .frame(maxWidth:  .infinity, alignment: .trailing)
                    .foregroundColor(.white)
                //                system size to make
                    .font(userInput.count <= 5 ? .system(size:90) : .system(size:55))
                    .padding()
                
                
                //                .self treats each row as an individual unique row
                ForEach(numsAndOperations.indices, id:\.self){ row in
                    HStack{
                        
                        ForEach(numsAndOperations[row], id:\.self){ ind in
                            //      if the button is this character make it this color
                            if ind == "AC" || ind == "+/-" || ind == "%" {
                                Button("\(ind)", action: {
                                    //                                    saying if the button clicked is AC run the ac function which cleans out everything and return the userInput 0
                                    if ind == "AC"{
                                        AC()
                                    }
                                    else if ind == "+/-"{
                                        negative()
                                    }
                                    else{
                                        percentage()
                                    }
                                })
                                //     makes the button appear bigger and with a border
                                //    also changes its color and text color
                                .frame(width: 80, height: 80 )
                                //                                UIcolor allows you to get other colors like light gray
                                .background(Color(UIColor.lightGray))
                                .foregroundColor(.black)
                                .cornerRadius(80)
                                //                                making the text inside the buttons bigger
                                .font(.system(size:30))
                                
                                
                            }
                            else if ind == "÷" || ind == "x" || ind == "-" || ind == "+" || ind == "=" {
                                Button("\(ind)", action: {
                                    //                                    if the buttton clicked is division, then append whatever the user types into numsafter and then divide them
                                    
                                    //            if the user clicks the equal button, print the answer
                                     if ind == "="{
                                             numsafter = userInput
                                             math()
                                             numsb4 = ""
                                             numsafter = ""
                                             operation = ""

                                    }
//                                    if it clicks another button, basically add the text into the numsb4 and store the button clicked into operation to kno whether to divide,multiply,etc.
                                    else{
                                        numsb4 = userInput
                                        operation = ind
                                        userInput = "0"
        
                                    }
                                    
                                    
                                    
                                })
                                .frame(width: 80, height: 80 )
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(80)
                                .font(.system(size:30))
                                
                                
                            }
                            else if ind == "0"{
                                Button("\(ind)", action: {
//                                    adding zero to the userInput so that it can replace
//                                    .count so that the user input doesnt go past 9
                                    if userInput.count != 9{
                                        if userInput == "0"{
                                            userInput = ind
                                            
                                        }
                                        else{
                                            userInput += ind
                                            
                                        }
                                    }
                                })
                                .frame(width: 170, height: 80 )
                                .background(Color(UIColor.darkGray))
                                .foregroundColor(.white)
                                .cornerRadius(80)
                                .font(.system(size:50))
                                
                            }
                            
                            else {
                                Button("\(ind)", action: {
//                                    make userinput equal to ind so it replaces the 0 at the beggining
 //                                    .count so that the user input doesnt go past 9
                                    if userInput.count != 9{
                                        if userInput == "0"{
                                            userInput = ind
                                            
                                        }
                                        else{
                                            userInput += ind
                                        }
                                    }
                    
                                })
                                //                                    changing the width for just zero by saying if the number is = to 0 then make it this width
                                
                                .frame(width: 80, height: 80)
                                .background(Color(UIColor.darkGray))
                                .foregroundColor(.white)
                                .cornerRadius(80)
                                .font(.system(size:40))
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    //    creating a function for the AC button
    func AC(){
        userInput = "0"
        numsb4 = ""
        numsafter = ""
        
    }
//    creating a function to turn the number into a negative
    func negative(){
        if let userInputt = Int(userInput){
//            multip;ying the number by negative one
            userInput = "\(userInputt * -1)"
        }
    }
    
//    turning the text into a percentage
    func percentage(){
        if let user = Double(userInput){
//            multilying the user input by 0.01 so it can be into a percent
            userInput = String(user * 0.01)
        }
    }
    
    
    //    creating a function to do the math like divide and multiply
    func math(){

//        .contains checks if the array or string contains that certain character
        if numsb4.contains(".") || numsafter.contains("."){
            decimalss()
        }else{
            integers()
        }
        
        
    }
    
    
//creating a function to deal with just the Int that arent decimals
    func integers(){
        if operation == "÷"{
        //        turning the string into a number
            if let nums1 = Int(numsb4), let nums2 = Int(numsafter){
                if nums2 != 0{
                    answer = nums1 / nums2
                    userInput = String(answer)

                }
                else{
                    userInput = "ERROR"
                }
            }
        }
        
        else if operation == "x"{
        //        turning the string into a number
            if let nums1 = Int(numsb4), let nums2 = Int(numsafter){
                answer = nums1 * nums2
                userInput = "\(answer)"

            }
        }
        
        else if operation == "-"{
        //        turning the string into a number
            if let nums1 = Int(numsb4), let nums2 = Int(numsafter){
                answer = nums1 - nums2
                userInput = "\(answer)"
            }
        }
          else{
        //        turning the string into a number
              if let nums1 = Int(numsb4), let nums2 = Int(numsafter){
                  answer = nums1 + nums2
                  userInput = "\(answer)"
            }
        }
    }
    
//creating a function to deal with decimals
    func decimalss(){
        if operation == "÷"{
        //        turning the string into a decimal
            if let nums1 = Double(numsb4), let nums2 = Double(numsafter){
                if nums2 != 0.0{
                    decimal = nums1 / nums2
                    userInput = "\(decimal)"

                }
                else{
                    userInput = "ERROR"
                }
            }
        }
        
        else if operation == "x"{
        //        turning the string into a decimal
            if let nums1 = Double(numsb4), let nums2 = Double(numsafter){
                decimal = nums1 * nums2
                userInput = "\(decimal)"

            }
        }
        
        else if operation == "-"{
        //        turning the string into a decimal
            if let nums1 = Double(numsb4), let nums2 = Double(numsafter){
                decimal = nums1 - nums2
                userInput = "\(decimal)"
            }
        }
          else{
        //        turning the string into a number
              if let nums1 = Double(numsb4), let nums2 = Double(numsafter){
                  decimal = nums1 + nums2
                  userInput = "\(decimal)"
            }
        }
        
        
    }
    }



#Preview {
    ContentView()


}
