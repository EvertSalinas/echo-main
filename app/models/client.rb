# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Client < ApplicationRecord
end
