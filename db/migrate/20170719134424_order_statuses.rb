class OrderStatuses < ActiveRecord::Migration[5.0]
  def change
    progress = Status.find_or_create_by name: 'В процессе оформления', status_type: 'order'
    progress.status_type = 'order'
    progress.code = 'in_progress'
    progress.save

    payment = Status.find_or_create_by name: 'Ожидает оплаты', status_type: 'order'
    payment.status_type = 'order'
    payment.code = 'payment'
    payment.save

    rejected = Status.find_or_create_by name: 'Отклонен', status_type: 'order'
    rejected.status_type = 'order'
    rejected.code = 'rejected'
    rejected.save

    delivery = Status.find_or_create_by name: 'Ожидает доставки', status_type: 'order'
    delivery.status_type = 'order'
    delivery.code = 'delivery'
    delivery.save

    archived = Status.find_or_create_by name: 'Завершен', status_type: 'order'
    archived.status_type = 'order'
    archived.code = 'archived'
    archived.save

    wait = Status.find_or_create_by name: 'Ожидает на складе', status_type: 'order'
    wait.status_type = 'order'
    wait.code = 'wait'
    wait.save

  end
end
