class Status < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '未処理' },
    { id: 3, name: '進行中' },
    { id: 4, name: '完了' }
  ]

  include ActiveHash::Associations
  has_many :tasks

end