//
//  ProductAddController.swift
//  WDrone
//
//  Created by 김도안 on 2018. 10. 29..
//  Copyright © 2018년 김도안. All rights reserved.
//

import UIKit
import Alamofire

class ProductAddController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var productId: HoshiTextField!
    @IBOutlet weak var productName: HoshiTextField!
    @IBOutlet weak var productAmount: HoshiTextField!
    @IBOutlet weak var productInput: HoshiTextField!
    @IBOutlet weak var productOutput: HoshiTextField!
    @IBOutlet weak var productImage: UIBarButtonItem!
    @IBOutlet weak var productSave: UIBarButtonItem!
    @IBOutlet weak var preview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        productId.resignFirstResponder()
        productName.resignFirstResponder()
        productAmount.resignFirstResponder()
        productInput.resignFirstResponder()
        productOutput.resignFirstResponder()
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        //이미지 피커 화면을 표시
        self.present(picker, animated: false);
    }
    @IBAction func save(_ sender: Any) {
        //내용 입력 안했을 경우 경고
        guard self.productId.text?.isEmpty == false else {
            self.alert("상품 코드를 입력해주세요.")
            return
        }
        
        //ProductData 객체를 생성하고, 데이터를 담는다.
        let profile = self.preview.image!.pngData()?.base64EncodedData();
        let param: Parameters = [
            "id" : self.productId.text!,
            "name" : self.productName.text!,
            "amount" : self.productAmount.text!,
            "inputDate" : self.productInput.text!,
            "outputDate" : self.productOutput.text!,
            "image" : profile!
        ]
        let alamo = Alamofire.request("http://35.194.119.42:8080/productadd", method: .post, parameters: param, encoding: URLEncoding.httpBody);
        
        alamo.responseString() { response in
            print("post=\(response.result.value!)");
            
            if response.result.value! == "1" {
                print("상품 등록 성공");
            } else {
                print("상품 등록 실패");
            }
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        picker.dismiss(animated: false)
    }
}
