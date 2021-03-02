//
//  ViewController.swift
//  CalculateBMI
//
//  Created by ちいつんしん on 2021/03/02.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak private var textField1: UITextField!
    @IBOutlet weak private var textField2: UITextField!

    private var calculate = Calculate()

    @IBOutlet weak private var bmiOutputLabel: UILabel!
    @IBOutlet weak private var standardWeightOutputLabel: UILabel!

    @IBAction func calculate(_ sender: Any) {

        do {
            let Output = try calculate.calculate(input: Input(height: textField1.text, weight: textField2.text))
            bmiOutputLabel.text = "\(Output.bmi)"
            standardWeightOutputLabel.text = "\(Output.standardWeight)"
        }catch let Calculate.Validation.正しく入力されていない(result: msg){
            print(msg)
        }catch{
        }

    }
}

struct Input {
    let height : String?
    let weight : String?
}

struct Output {
    let bmi : String
    let standardWeight :String
}

class Calculate{

    enum Validation: Error {
        case 正しく入力されていない(result: String)
    }

    func calculate(input: Input) throws -> Output{

        let height = Double(input.height ?? "")
        let weight = Double(input.weight ?? "")

        guard let _height = height, let _weight = weight else {
            throw Validation.正しく入力されていない(result: "正しく入力されていません")
        }

        let meterHegiht = _height/100

        let bmi = round((_weight/(meterHegiht*meterHegiht))*100)/100
        let standardHeight = round((meterHegiht*meterHegiht)*22)*100/100

        return Output(bmi: "\(bmi)", standardWeight:"\( standardHeight)")

    }

}

