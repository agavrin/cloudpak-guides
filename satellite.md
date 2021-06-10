## Настройка IBM Cloud Satellite в облаке IBM Cloud

### 1. Выдача доступа для управления ресурсами IBM Cloud Satellite

#### 1.1. Пригласить пользователей для доступа к ресурсам IBM Cloud Satellite

- Залогиньтесь в IBM Cloud https://cloud.ibm.com/
- В меню доступа выберите - **Manage** > **Access (IAM)**
- Перейдите в меню **Users** (или перейдите по короткой ссылке https://cloud.ibm.com/iam/users) -  здесь указаны пользователи, которых вы добавили к управлению облачными ресурсами. Для добавления нового пользователя - нажмите **Invite Users**, введите email сотрудника (или нескольких сотрудников) и нажмите **Invite**. Ваши сотрудники получат приглашение на электронную почту, и должны будут его подтвердить.

#### 1.2. Дать полный доступ к созданию ресурсов в облаке IBM Cloud
- Нажмите **Manage** > **Access (IAM)**, затем - **Access groups** (или перейдите по короткой ссылке https://cloud.ibm.com/iam/groups/), и нажмите **Create**, чтобы создать группу сотрудников для управления ресурсами IBM Cloud. Вам потребуется ввести ее имя (например, **IBM Cloud Administrators**), и нажать **Create**
- Имя группы появится в списке - нажмите на эту группу, чтобы настроить уровни доступа и добавить участников.
- Нажмите **Access Policies** - **Assign Access**
- При выбранном пункте **IAM Services**, в списке сервисов выберите **All Identity and Access enabled services**.
- Нажмите **Administrator** в группе **Platform Access**
- Нажмите **Manager** в группе **Service Access**
- Нажмите **Administrator** в группе **Resource group access**
- Нажмите **Add**
- Нажмите **Assign**

#### 1.3. Дать доступ к просмотру биллинга в облаке IBM Cloud
- Нажмите **Manage** > **Access (IAM)**, затем - **Access groups** (или перейдите по короткой ссылке https://cloud.ibm.com/iam/groups/), выберите группу, которой вы хотите дать доступ к биллингу (например, **IBM Cloud Administrators**)
- Нажмите на эту группу, чтобы настроить уровни доступа и добавить участников.
- Нажмите **Access Policies** - **Assign Access**
- При выбранном пункте **Account management**, в списке сервисов выберите **Billing**.
- Нажмите **Administrator** в группе **Platform Access**
- Нажмите **Viewer** в группе **Platform Access** для выдачи разрешения на просмотр данных по использованию сервисов
- Нажмите **Add**
- Нажмите **Assign**


#### 1.4. Создание группы пользователей для управления IBM Cloud Satellite
- Нажмите **Manage** > **Access (IAM)**, затем - **Access groups** (или перейдите по короткой ссылке https://cloud.ibm.com/iam/groups/), и нажмите **Create**, чтобы создать группу сотрудников для управления ресурсами IBM Cloud Satellite. Вам потребуется ввести ее имя (например, **IBM Cloud Satellite Editors**), и нажать **Create**
- Имя группы появится в списке - нажмите на эту группу, чтобы настроить уровни доступа и добавить участников.
- Нажмите **Access Policies** - **Assign Access**
- При выбранном пункте **IAM Services**, в списке сервисов выберите **Satellite**.
- Выберите **Administrator** для получения полного доступа к ресурсам, а также укажите следующие уровни доступа для работы с Satellite:
	- Manager
	- Deployer
	- Satellite Cluster Creator
	- Satellite Link Administrator
	- Satellite Link Source Access Controller
- Нажмите **Add**
- При выбранном пункте **IAM Services**, в списке сервисов выберите **Cloud Object Storage**.
- Выберите **Administrator** для получения полного доступа к ресурсам, а также укажите следующие уровни доступа для работы с Satellite:
	- Manager
	- Content Reader
	- Object Reader
	- Object Writer
- Нажмите **Add**
- Нажмите **Assign**



#### 1.3. Добавить пользователей в группу
- В меню доступа выберите - **Manage** > **Access (IAM)** -> **Access Groups** (или перейдите по короткой ссылке https://cloud.ibm.com/iam/groups/)
- Откройте нужную вам группу
- В закладке **Users** Нажмите **Add users**, пометьте тех, кого хотите включить в группу, и нажмите **Add to group**.

*Внимание!* В списке пользователей вы увидите только тех, кто уже подтвердил приглашение, полученное по электронной почте.
