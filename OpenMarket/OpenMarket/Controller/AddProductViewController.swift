//  Created by Aejong, Tottale on 2022/11/22.

import UIKit

final class AddProductViewController: UIViewController {
    
    let addView = ProductAddView()
    let imagePicker = UIImagePickerController()
    var imageCount = 0
    var textFieldConstraint: NSLayoutConstraint?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureImagePicker()
        configureNavigationBar()
        configureDoneButton()
        configureCancelButton()
        configureAddImageButton()
        configureView()
        initializeHideKeyBoard()
    }
    
    private func configureView() {
        self.view = addView
        addView.descriptionTextView.delegate = self
    }
    
    private func configureNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = .clear
        self.navigationItem.title = "상품등록"
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
    
    private func configureDoneButton() {
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                       action: nil)
        self.navigationItem.rightBarButtonItem = doneItem
    }
    
    private func configureCancelButton() {
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                         action: #selector(cancelButtonPressed))
        self.navigationItem.leftBarButtonItem = cancelItem
    }
    
    private func configureAddImageButton() {
        self.addView.photoAddButton.addTarget(self, action: #selector(imageAddButtonPressed), for: UIControl.Event.touchUpInside)
    }
    
    private func configureImagePicker() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.delegate = self
    }
    
    @objc private func cancelButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func imageAddButtonPressed(_ sender: UIButton) {
        guard imageCount < 5 else { return }
        self.present(self.imagePicker, animated: true)
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.addView.addImageView(with: image)
        }
        imageCount += 1
        dismiss(animated: true, completion: nil)
    }

}

extension AddProductViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.addView.imageScrollView.isHidden = true
        textFieldConstraint =  self.addView.textFieldStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        textFieldConstraint?.isActive = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textFieldConstraint?.isActive = false
        self.addView.imageScrollView.isHidden = false
    }
    
    func initializeHideKeyBoard() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyBoard))
        self.addView.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyBoard() {
        self.addView.endEditing(true)
    }
}
