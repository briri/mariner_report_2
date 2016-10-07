# Keywords that will cause us to ignore a publisher's article
#
# Global censure keywords can be found in the config files
class Censure < ApplicationRecord
  belongs_to :publisher
end