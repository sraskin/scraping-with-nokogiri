# == Schema Information
#
# Table name: agents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  license_no :string(255)
#  address    :text(65535)
#  phone      :string(255)
#  mobile     :string(255)
#  fax        :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Agent < ActiveRecord::Base

end
