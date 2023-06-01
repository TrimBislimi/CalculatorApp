//
//  ViewController.swift
//  Calculator
//
//  Created by Trim Bislimi on 01.03.23.
//

import UIKit

class ViewController: UIViewController
{

    
    
    @IBOutlet weak var calculatorWorkings: UILabel! //hier wird gerechnet
    @IBOutlet weak var calculatorResults: UILabel! //zeigt das Resultat an
    
    var workings:String = "" //leeres worgins als String
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        clearAll() //Workings und Results wird gecleard
        
    }
    
    func clearAll() //Löscht alles was bei der Anzeige im Workings und Results drinnen ist.
    {
        workings = ""
        calculatorWorkings.text = ""
        calculatorResults.text = ""
    }

    
    @IBAction func equalsTap(_ sender: Any)
    {
        if(validInput()) // Wenn de Eingabe valid ist.
        {//let ist ein Schlüsselwort zu deklaration von Konstanten (Wert verändert sich nicht)
            let checkedWorkingsForPercent = workings.replacingOccurrences(of: "%", with: "*0.01") //Wenn Prozent in workings ist, wird diese mit *0.01 ersetzt.
            let expression = NSExpression(format: checkedWorkingsForPercent) //ruft checkedWorkingsForPercent als Objekt durch NSExpression auf.
            
            
            //mit NSExpression und dem objekt expressionValue wird die der Wert ausgerechnet und in result als Double gespeichert.
            let result = expression.expressionValue(with: nil, context: nil) as! Double
            
            //der berechnete Wert result wird in Zeichenfolge mit formatResult umgewandelt und in resultString gespeichert
            let resultString = formatResult(result: result)
            
            //resultString wird als Text in UILabel angezeigt
            calculatorResults.text = resultString
        }
        else
        {
            //neue UIAlertController Klasse mit title und message. .alert ist ein PopUp
            let alert = UIAlertController(title: "Invalid Input", message: "Calculator unable to do math based on Input", preferredStyle: .alert)
            //Aktion die ausgeführt wird wenn auf Okay gedrückt. der stil ist .default
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            //erster Parameter ist die benachrichtigung, dann ob diese animiert werden soll und zuletzt ob es eine Aktion erfordert.
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validInput() -> Bool //gibt einen Boolean-Wert zürick
    {
        var count = 0 //Zähler um zu wisser an welcher Stelle in String sich befindet.
        var funcCharIndexes = [Int]() //Leere Liste um zu speichern wo die speziellen Zeichen sind.
        for char in workings //Schleife die jeden Buchstaben im String workings durchläuft
        {
            if(specialCharacter(char: char)) // ob Buchstabe ein spezielles Zeichen ist
            {
                funcCharIndexes.append(count) //die Postion des Buchstabens "count" wird zu Liste hinzugefügt
            }
            count += 1 //+ 1 umzum nächsten Buchstaben im String zu wechseln
        }
        
        var previous: Int = -1 //um den index des vorherigen speziellen Zeichen im String zu speichern
        
        for index in funcCharIndexes //läuft jeden index in FuncCharIndexes durch
        {
            if(index == 0) //ob der index des aktuellen speziellen Zeichens am Anfang des String workings liegt.
            {
                return false //Eingabe ungültig da Spezielle Zeichen a Anfang
            }
            
            if(index == workings.count - 1) //ob der index des aktuellen speziellen Zeichens am Ende des String workings liegt.
            {
                return false //Eingabe ungültig da Spezielle Zeichen a Ende
            }
            
            if (previous != -1) //schaut ob es ein vorheriges spezielles Zeichen im String hat.
            {
                if(index - previous == 1) //Wenn differenz gleich 1 ist, heisst es spezielle Zeichen sind aufeinanderfolgend
                {
                    return false
                }
            }
            previous = index //aktueller Index wird in previous gespeichert.
            

        }
        
        return true //Eingabe ist gültig
    }
    
    func specialCharacter (char: Character) -> Bool //Char wird kontrolliert ob speziallzeichen, gibt bool zurück
    {
        if(char == "*")
        {
            return true
        }
        if(char == "/")
        {
            return true
        }
        if(char == "+")
        {
            return true
        }
        if(char == "-")
        {
            return true
        }
        return false
    }
    
    func formatResult(result: Double) -> String //formatiert Double zu String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0) //ob result ohne Rest durch 1 teilbar
        {
            return String(format: "%.0f", result) //gibt result als String zurück ohne Dezimalstellen
        }
        else
        {
            return String(format: "%.02f", result) //gibt result als String zurück mit zwei Nachkommastellen. %f gibt Dezimalzahl and und %.02 gib zwei Dezimalstellen.
        }
    }
    
    @IBAction func allClearTap(_ sender: Any)
    {
        clearAll() //nimmmt funktion clearAll um die Anzeige zu löschen
    }
    
    @IBAction func backTap(_ sender: Any)
    {
        if(!workings.isEmpty) //wenn workings nicht leer ist, dann wird das letzte von workings entfernt
        {
            workings.removeLast()
            calculatorWorkings.text = workings
        }
    }
    
    func addToWorkings(value: String) //String value wird als Parameter akzeptiert und fügt value String am Ende des working Strings an.
    {
        workings = workings + value
        calculatorWorkings.text = workings
    }
    
    @IBAction func percentTap(_ sender: Any)
    {
        addToWorkings(value: "%")
    }
    
    @IBAction func divideTap(_ sender: Any)
    {
        addToWorkings(value: "/")
    }
    
    @IBAction func timesTap(_ sender: Any)
    {
        addToWorkings(value: "*")
    }
    
    @IBAction func minusTap(_ sender: Any)
    {
        addToWorkings(value: "-")
    }
    
    @IBAction func plusTap(_ sender: Any)
    {
        addToWorkings(value: "+")
    }
    
    @IBAction func decimalTap(_ sender: Any)
    {
        addToWorkings(value: ".")
    }
    
    @IBAction func zeroTap(_ sender: Any)
    {
        addToWorkings(value: "0")
    }
    
    @IBAction func oneTap(_ sender: Any)
    {
        addToWorkings(value: "1")
    }
    
    @IBAction func twoTap(_ sender: Any)
    {
        addToWorkings(value: "2")
    }
    
    @IBAction func threeTap(_ sender: Any)
    {
        addToWorkings(value: "3")
    }
    
    @IBAction func fourTap(_ sender: Any)
    {
        addToWorkings(value: "4")
    }
    
   
    @IBAction func fiveTap(_ sender: Any)
    {
        addToWorkings(value: "5")
    }
    
 
    @IBAction func sixTap(_ sender: Any)
    {
        addToWorkings(value: "6")
    }
    
    
    @IBAction func sevenTap(_ sender: Any)
    {
        addToWorkings(value: "7")
    }
    
    @IBAction func eightTap(_ sender: Any)
    {
        addToWorkings(value: "8")
    }
    
    @IBAction func nineTap(_ sender: Any)
    {
        addToWorkings(value: "9")
    }
    
    
}

