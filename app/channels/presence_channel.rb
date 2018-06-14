# class PresenceChannel < ApplicationCable::Channel
#     def subscribed
#         current_user.appear
#     end

#     def unsubscribed
#         current_user.disappear
#     end

#     def appear(data)
#         current_user.appear(on: data['appearing_on'])
#     end

#     def away
#         current_user.away
#     end

#     # define methods and create client-side subscription to this channel
# end