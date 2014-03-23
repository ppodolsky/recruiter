class ActionController::Parameters
  def rangize
    @result = Hash.new
    self.to_h.each do |f|
      if f[0].to_s.end_with?('_from')
        puts f[0].to_s[0..-6] + '_to'
        puts self[f[0].to_s[0..-6] + '_to']
        @result[f[0].to_s[0..-6]] = f[1]..self[f[0].to_s[0..-6] + '_to']
      elsif f[0].to_s.end_with?('_to')
        @result[f[0].to_s[0..-4]] = self[f[0].to_s[0..-4] + '_from']..f[1]
      else
        @result[f[0].to_s] = self[f[0].to_s]
      end
    end
    @result
  end
end