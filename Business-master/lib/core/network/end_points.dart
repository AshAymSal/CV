/// AUTH
const LOGIN = "login";
const REGISTER = "register";
const VERIFY = "verify";
const FORGET_PASSWORD = "forgetpassword";
const RESET_PASSWORD = "newpassword";
const getAllCountryPath = "countries";
const getAllCitiesPath = "cities";

/// Company
const getAllCompanyPath = "companies";

/// Groups and Pages
const allGroupPath = "auth/groups/0";
const allPagesPath = "auth/pages/0";

const myGroupPath = "auth/groups/1";
const myPagesPath = "auth/pages/1";

const joinGroup = "auth/entergroup";
const joinPage = "auth/likepage";

const showGroupDetailsPath = "auth/group/details";
const showPageDetailsPath = "auth/page/details";

const ShowGroupMember = "auth/group/members/collection";
const showGroupMemberPending = "auth/group/members/collection/pending";
const showGroupMemberAcceptedOrDeleted = "auth/group/members/handle";
const ShowPageMember = "auth/page/members/collection";

const createGroupPath = "auth/addGroup";
const createPagePath = "auth/addPage";

const GET_GROUP_CATEGORY = "categories";
const getAllServicesPath = "services";
const Add_Post_Group = "auth/addPost";
const Get_Photo_Group = "auth/group/media";

/// Services
const addServicePath = "auth/addService";
const getCategoriesPath = "categories";

/// Posts
const getAllPostsPath = "auth/getPosts";
const Get_Post_Comments = "auth/getPostComments";
const Get_Post_SHARES = "auth/group/post/get/share";
const sharePostPath = "auth/group/post/add/share";
const Get_Post_Likes = "auth/getPostLikes";
const Add_Update_Delete_Post_Likes = "auth/addLike";

/// Comments
const ADD_CommentsPath = "auth/addComment";
const Edit_CommentsPath = "auth/updateComment";
const deleteCommentsPath = "auth/removeComment";
const reportCommentsPath = "auth/addReport";

/// Favorite TODO :
const getAllFavoritePath = "";
const addToFavoritePath = "";
const deleteFromFavoritePath = "";

/// Profile
const getProfileDetailsPath = "profile";
const profileEditPath = "profileEdit";

/// Music
const getAllMusicPath = "profile/musics/view";
const addMusicPath = "profile/musics/add";
const deleteMusicPath = "profile/musics/remove";

/// Sports
const allSportsPath = "profile/sports/view/all";
const mySportsPath = "profile/sports/view";
const addSportsPath = "profile/sports/add";
const removeSportsPath = "profile/sports/remove";

/// Sports
const allHobbiesPath = "profile/hobbies/view/all";
const myHobbiesPath = "profile/hobbies/view";
const addHobbiesPath = "profile/hobbies/add";
const removeHobbiesPath = "profile/hobbies/remove";

/// inspirations
const getAllInspirationsPath = "profile/inspirations/view";
const removeInspirationsPath = "profile/inspirations/remove";

/// Setting Profile
const uploadImagePath = "profileImage";

/// Home
const homePostsPath = "getPosts";
const homeStoriesPath = "getStories";
const addStoryPath = "addStory";
const deleteStoryPath = "deleteStory";

/// Follow
const addFollowPath = "auth/follow";
const unFollowPath = "auth/unfollow";
