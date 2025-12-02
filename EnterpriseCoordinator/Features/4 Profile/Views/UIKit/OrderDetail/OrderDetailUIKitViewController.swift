//
//  OrderDetailUIKitViewController.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import UIKit

final class OrderDetailUIKitViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: TabCoordinator<ProfileRoute>!
    var orderId: String!
    private var scrollView: UIScrollView!
    private var contentStackView: UIStackView!
    
    private var order: Order? {
        Order.mockOrders.first { $0.id == orderId }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupContent()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "Заказ #\(orderId ?? "")"
        view.backgroundColor = .systemBackground
        
        // ScrollView
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // StackView
        contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
        
        // Кнопка Pop
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(popButtonTapped)
        )
    }
    
    private func setupContent() {
        guard let order = order else { return }
        
        // Информация о заказе
        let infoCard = createCard(title: "Информация")
        infoCard.addArrangedSubview(createInfoRow(title: "Номер:", value: "#\(order.id)"))
        
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        infoCard.addArrangedSubview(createInfoRow(title: "Дата:", value: formatter.string(from: order.date)))
        infoCard.addArrangedSubview(createInfoRow(title: "Статус:", value: order.status.rawValue))
        
        contentStackView.addArrangedSubview(infoCard)
        
        // Товары
        let itemsCard = createCard(title: "Товары")
        for item in order.items {
            let itemView = createItemRow(item: item)
            itemsCard.addArrangedSubview(itemView)
        }
        
        contentStackView.addArrangedSubview(itemsCard)
        
        // Итого
        let totalCard = createCard(title: "Итого")
        let totalLabel = UILabel()
        totalLabel.text = "₽\(Int(order.totalAmount))"
        totalLabel.font = .systemFont(ofSize: 24, weight: .bold)
        totalLabel.textAlignment = .center
        totalCard.addArrangedSubview(totalLabel)
        
        contentStackView.addArrangedSubview(totalCard)
    }
    
    // MARK: - Helper Methods
    
    private func createCard(title: String) -> UIStackView {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 12
        container.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        container.isLayoutMarginsRelativeArrangement = true
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        container.addArrangedSubview(titleLabel)
        
        return container
    }
    
    private func createInfoRow(title: String, value: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        titleLabel.textColor = .secondaryLabel
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 15)
        valueLabel.textAlignment = .right
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(valueLabel)
        
        return stack
    }
    
    private func createItemRow(item: OrderItem) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        
        let nameLabel = UILabel()
        nameLabel.text = "\(item.name) × \(item.quantity)"
        nameLabel.font = .systemFont(ofSize: 15)
        
        let priceLabel = UILabel()
        priceLabel.text = "₽\(Int(item.price))"
        priceLabel.font = .systemFont(ofSize: 15, weight: .medium)
        priceLabel.textAlignment = .right
        
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(priceLabel)
        
        return stack
    }
    
    // MARK: - Actions
    
    @objc private func popButtonTapped() {
        coordinator.pop()
    }
}
