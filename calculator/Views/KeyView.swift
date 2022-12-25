//
//  KeyView.swift
//  calculator
//
//  Created by Arunangshu Das on 25/12/22.
//

import SwiftUI

struct KeyView: View {
    
    @State var value="0"
    @State var runningNumber=0.0
    @State var currentOperation:Operation = .none
    @State private var changeColor=false
    @State var flag=0
    
    let buttons:[[Keys]]=[
        [.clear,.sqrt,.percentage,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.negative,.decimal,.equal]
    ]
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(changeColor ? Color("num").opacity(0.1)
                                     : Color.pink.opacity(0.1))
                    .scaleEffect(changeColor ? 10 : 1.0)
                    .frame(width: 350,height: 280)
                    .animation(Animation.easeInOut.speed(0.017).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        self.changeColor.toggle()
                    })
                    .overlay(Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.red)
                )
            }.padding()
            ForEach(buttons,id:\.self){ row in
                HStack(spacing: 12){
                    ForEach(row,id:\.self){ elem in
                        Button {
                            self.didTap(button: elem)
                        } label: {
                            Text(elem.rawValue)
                                .font(.system(size: 30))
                                .frame(width:self.getWidth(elem: elem),height: self.getHeight(elem: elem))
                                .background(elem.buttonColor)
                                .foregroundColor(.black)
                                .cornerRadius(self.getWidth(elem: elem))
                                .shadow(color: .gray,radius: 30)
                        }

                    }
                }.padding(.bottom,4)
            }
        }
    }
    
    func getWidth(elem :Keys)->CGFloat{
        return (UIScreen.main.bounds.width-(5*12))/4
    }
    
    func getHeight(elem :Keys)->CGFloat{
        return (UIScreen.main.bounds.width-(5*5))/5
    }
    
    func didTap(button:Keys)
    {
        switch button{
        case .add,.subtract,.multiply,.divide,.equal,.sqrt,.percentage:
                if button == .add{
                    self.currentOperation = .add
                    self.runningNumber = Double(self.value) ?? 0
                    self.value="0"
                }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
                self.value="0"
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
                self.value="0"
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
                self.value="0"
            }
            else if button == .sqrt{
                self.currentOperation = .sqrt
                self.runningNumber = Double(self.value) ?? 0
                self.value="0"
            }
            else if button == .percentage{
                self.currentOperation = .percentage
                self.runningNumber = Double(self.value) ?? 0
                self.value="0"
            }
            else if button == .equal{
                let runningValue=self.runningNumber
                let currentvalue=Double(self.value) ?? 0
                self.flag=1
                switch self.currentOperation{
                case .add:
                    self.value="\(runningValue + currentvalue)"
                case .subtract:
                    self.value="\(runningValue - currentvalue)"
                case .multiply:
                    self.value="\(runningValue * currentvalue)"
                case .divide:
                    self.value="\(runningValue / currentvalue)"
                case .percentage:
                    self.value="\(Int(runningValue) % Int(currentvalue))"
                case .sqrt:
                    self.value="\(sqrt(currentvalue>0 ? Double(currentvalue) : 0))"
                case .none:
                    break
                }
            }
        case .clear:
            self.value="0"
        case .negative:
            self.value="-"+self.value
        default:
            let number=button.rawValue
            if self.flag==1{
                self.value="0"
                self.flag=0
            }
            if self.value=="0"{
                self.value=number
            }
            else
            {
                self.value="\(self.value)\(number)"
            }
        }
    }
    
}

struct KeyView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
