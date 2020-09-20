## Working on the GB Data alond from PULSEMASTER 
#install.packages("reshape")
#library(reshape)

#GB Users alone : 
          # GB_USERS = Country_User_M %>% filter(country == "GB")
          # c = GB_USERS[,2]
          # 
          # ## testing if Users are availabkle in dataset: 
          # #0100f873
          #  
          # filter(GB_USERS,masked_user_id == "0b0ddba9")             # 1 record
          # filter(pulsescore_Master_All,masked_user_id == "0b0ddba9") # 0 records 
          # filter(pulsescore_Master_GB,masked_user_id == "0b0ddba9") # 44 records 
          # 
          # 
          # ## Pulling out the PULSESCORE from ALL Scores, only for GB 
          # merge(pulsescore_Master_All,pulsescore_Master_GB, by=c("masked_user_id")) ## Not working - No Rows returned 
          # merge(pulsescore_Master_All,GB_USERS, by=c("masked_user_id"))  #==> # Giving me 0 records 
          # merge(pulsescore_Master_GB,GB_USERS, by=c("masked_user_id"))  #==> # Giving me 24553 records 
          # 
          # # Users sued to Test ==> 0100f873 / 011973bf / 0b0ddba9
          # 
          # # Combining Pulsescore data with Other User infomration 
          # PS_User_data = unique(merge(pulsescore_Master_GB, master_dt[,c("masked_user_id","org_id","lang_code","role_id","country")], by = c("masked_user_id")))
          # 
          # 
          # ####1)  To Create a new variable to find out the points earned.. 
          # new_var <- "qns_ans"
          # assess_dt[,(new_var):=dplyr::case_when(
          #   qns_ans = points_earned == 10 ~ 1,
          #   qns_ans = points_earned == 5 ~ 1,
          #   qns_ans = points_earned == 0 ~ 0)]
          # 
          # 
          # ####2)  To Create  a new variable to find out the stream viewed.. 
          # new_var <- "completed"
          # views_dt[,(new_var):=dplyr::case_when(
          #   completed = action == "STREAM_COMPLETE" ~ 1,
          #   completed = action == "STREAM_RECIEVED" ~ 0)]
          # 
          # ## Mergin PS User Data with ASSESS_DT 
          # new_Assess_dt = merge(assess_dt, PS_User_data, on = c("masked_user_id","question_tags"))
          # new_Assess_dt[,c("X")] <- NULL # without the User Count Field 
          # new_Assess_woTime_dt = unique(new_Assess_dt[,-c("submission_utc_ts")]) # Without the submission timestamp


# Creating Recommended Question output

## After Recommendation, need to pull out the Questions now: 
Questions_Recommended_0 = merge(C_Q_Tag_M, Recommended_Recolabs_Tag_ALL, by= c("question_tags"),allow.cartesian=TRUE)

## Merging with u_q_t_m to find out which of the questions recommended have already been answered by users 
Questions_Recommended_w_qns_ans = unique(merge(Questions_Recommended,u_q_t_M,  by= c("masked_user_id","question_id"),all.x = TRUE))
Questions_Recommended_w_qns_ans[,c("no_of_trials","points_earned")] <- NULL
Questions_Recommended_w_qns_ans = unique(Questions_Recommended_w_qns_ans)

filter(u_q_t_M, qns_ans == "1")
filter(pulsescore_Master_GB_O28_DO, score != "0")
Questions_Recommended_w_qns_ans_GB_Users = filter(Questions_Recommended_w_qns_ans, country == "GB")
setorder(Questions_Recommended_w_qns_ans_GB_Users, masked_user_id,question_id,-qns_ans)


    #finding Qns Recommended for Users on Day 1  
    Qns_Reco_Day1 = filter(Questions_Recommended_w_qns_ans_GB_Users, masked_user_id %in% Demo_UsersDay0)
    ## Finding out the top 5 Questions for each User 
#??!!==>TO DO     ## ==> What do we need to post it as 
    
    ## Picking up the first 5 lines for each user 
    ==> https://stackoverflow.com/questions/14800161/select-the-top-n-values-by-group
    
    
