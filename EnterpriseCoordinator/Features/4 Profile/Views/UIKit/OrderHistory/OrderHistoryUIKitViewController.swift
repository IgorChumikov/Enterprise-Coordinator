//
//  OrderHistoryUIKitViewController.swift
//  EnterpriseCoordinator
//
//  Created by Игорь Чумиков on 02.12.2025.
//

import UIKit

final class OrderHistoryUIKitViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: TabCoordinator<ProfileRoute>!
    private var tableView: UITableView!
    private let orders = Order.mockOrders
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "📋 История (UIKit)"
        view.backgroundColor = .systemBackground
        
        // Кнопка для перехода на SwiftUI экран
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Завершенные",
            style: .plain,
            target: self,
            action: #selector(showCompletedOrders)
        )
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        view.addSubview(tableView)
    }
    
    // MARK: - Actions
    
    @objc private func showCompletedOrders() {
        // ✨ Переход на SwiftUI экран
        coordinator.push(.completedOrders)
    }
}

// MARK: - UITableViewDataSource

extension OrderHistoryUIKitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        let order = orders[indexPath.row]
        cell.configure(with: order)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension OrderHistoryUIKitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let order = orders[indexPath.row]
        
        // ✨ Переход на UIKit детали заказа
        coordinator.push(.orderDetailUIKit(id: order.id))
    }
}

// MARK: - Custom Cell

private class OrderCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with order: Order) {
        textLabel?.text = "Заказ #\(order.id) - \(order.status.rawValue)"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: order.date)
        
        detailTextLabel?.text = "\(dateString) • ₽\(Int(order.totalAmount))"
        
        // Цвет статуса
        switch order.status {
        case .completed:
            textLabel?.textColor = .systemGreen
        case .pending:
            textLabel?.textColor = .systemOrange
        case .cancelled:
            textLabel?.textColor = .systemRed
        }
    }
}
