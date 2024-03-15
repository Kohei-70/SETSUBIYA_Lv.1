class Quiz < ApplicationRecord
  def self.search_for(content, method)
    if method == 'perfect'
      Quiz.where(name: content)
    elsif method == 'forward'
      Quiz.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Quiz.where('name LIKE ?', '%' + content)
    else
      Quiz.where('name LIKE ?', '%' + content + '%')
    end
  end
  
  # def self.search_for(content, method)
  #   if method == 'perfect'
  #     where("name LIKE ?", content)
  #   elsif method == 'forward'
  #     where("name LIKE ?", content + '%')
  #   elsif method == 'backward'
  #     where("name LIKE ?", '%' + content)
  #   else
  #     where("name LIKE ?", '%' + content + '%')
  #   end
  # end
end
