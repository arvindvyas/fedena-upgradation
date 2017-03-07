# == Schema Information
#
# Table name: observations
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  desc                 :string(255)
#  is_active            :boolean
#  observation_group_id :integer
#  created_at           :datetime
#  updated_at           :datetime
#  sort_order           :integer
#

#Fedena
#Copyright 2011 Foradian Technologies Private Limited
#
#This product includes software developed at
#Project Fedena - http://www.projectfedena.org/
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
class Observation < ActiveRecord::Base

  belongs_to :observation_group

  has_many :descriptive_indicators, as: :describable
  has_many :assessment_scores, through: :descriptive_indicators
  has_many :cce_reports, as: :observable
  has_many :observations, through: :observation_group


  accepts_nested_attributes_for :descriptive_indicators
 # has_one :dob, ->(dob) { where("Date.new(2000, 01, 01) > ?", dob) }
  has_one :next_record, ->(obj) { observations.where('order > ?', obj.order) }
  default_scope { order('sort_order ASC')}
  scope :active, -> { where(is_active: true)}

  # def next_record
  #   .first
  # end
  def prev_record
    observation_group.observations.where('order < ?',order).last
  end

  def validate
    errors.add(:base, "Name can't be blank") if self.name.blank?
    errors.add(:base, "Description can't be blank") if self.desc.blank?
  end
end
