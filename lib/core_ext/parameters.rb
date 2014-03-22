class ActionController::Parameters
  def rangize
    @temp = self.copy
    @res = Array.new
    self.each do |f|
      if f.to_s.end_with?('_from') and @temp.include?(f.to_s[0..-5] + 'to')
        @res[f.to_s[0..-5]] = @temp[f.to_s]..@temp[f.to_s[0..-5] + '_to']
        @temp.delete f.to_s[0..-5] + '_to'
      elsif f.to_s.end_with?('_to') and @temp.include?(f.to_s[0..-3] + '_from')
        @res[f.to_s[0..-3]] = @temp[f.to_s[0..-3] + '_from']..@temp[f.to_s]
        @temp.delete f.to_s[0..-3] + '_from'
      else
        @res[f.to_s] = @temp[f.to_s]
      end
      @temp.delete f.to_s
    end
    @res
  end
end