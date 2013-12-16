module DynamoAutoscale
  class UnitCost
    # Pricing information obtained from: http://aws.amazon.com/dynamodb/pricing/
    HOURLY_PRICING = {
      'us-east-1' => {
        read:  { dollars: 0.0065, per: 50 },
        write: { dollars: 0.0065, per: 10 },
      },
      'us-west-1' => {
        read:  { dollars: 0.0065, per: 50 },
        write: { dollars: 0.0065, per: 10 },
      },
    }

    # Returns the cost of N read units for an hour in the region given by
    # AWS.config.region
    #
    # Example:
    #
    #   DynamoAutoscale::UnitCost.read(500)
    #   #=> 0.065
    def self.read units, opts = {}
      if pricing = HOURLY_PRICING[AWS.config.region]
        ((units / pricing[:read][:per].to_f) * pricing[:read][:dollars])
      else
        nil
      end
    end

    # Returns the cost of N write units for an hour in the region given by
    # AWS.config.region.
    #
    # Example:
    #
    #   DynamoAutoscale::UnitCost.write(500)
    #   #=> 0.325
    def self.write units, opts = {}
      if pricing = HOURLY_PRICING[AWS.config.region]
        ((units / pricing[:write][:per].to_f) * pricing[:write][:dollars])
      else
        nil
      end
    end
  end
end
