/*----------------------------------------------------------------------------
 * Copyright (c) <2016-2018>, <Huawei Technologies Co., Ltd>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice, this list of
 * conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * 3. Neither the name of the copyright holder nor the names of its contributors may be used
 * to endorse or promote products derived from this software without specific prior written
 * permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *---------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------
 * Notice of Export Control Law
 * ===============================================
 * Huawei LiteOS may be subject to applicable export control laws and regulations, which might
 * include those applicable to Huawei LiteOS of U.S. and the country in which you are located.
 * Import, export and usage of Huawei LiteOS in any manner by you shall be in compliance with such
 * applicable export control laws and regulations.
 *---------------------------------------------------------------------------*/

//include the file which implement the function
#include  <osal_imp.h>

///< this is implement for the task
#include <los_task.ph>
#include <los_task.h>
static void __task_sleep(int ms)
{
    LOS_TaskDelay(ms);//which tick is ms
    return;
}

static void *__task_create(const char *name,int (*task_entry)(void *args),\
        void *args,int stack_size,void *stack,int prior)
{
    void *ret = NULL;
    UINT32 uwRet = LOS_OK;
    UINT32  handle;
    TSK_INIT_PARAM_S task_init_param;

    memset (&task_init_param, 0, sizeof (TSK_INIT_PARAM_S));

    task_init_param.uwArg = (unsigned int)args;
    task_init_param.usTaskPrio = prior;
    task_init_param.pcName =(char *) name;
    task_init_param.pfnTaskEntry = (TSK_ENTRY_FUNC)task_entry;
    task_init_param.uwStackSize = stack_size;
    uwRet = LOS_TaskCreate(&handle, &task_init_param);
    if(LOS_OK != uwRet){
        return ret;
    }
    ret = (void *)handle;
    return ret;
}

static int __task_kill(void *task)
{
	int ret = -1;
	UINT32 handle;
	if(NULL != task)
	{
		handle = (UINT32) task;
		if(LOS_OK == LOS_TaskDelete(handle))
		{
			ret = 0;
		}
	}

	return ret;
}

static int __task_exit()
{
	while(1);  //not supported yet

	return 0;
}

///< this is implement for the mutex
#include <los_mux.h>
//creat a mutex for the os
static bool_t  __mutex_create(mutex_t *mutex)
{
    if(LOS_OK == LOS_MuxCreate((UINT32 *)mutex))
    {
        return true;
    }
    else
    {
        return false;
    }
}
//lock the mutex
static bool_t  __mutex_lock(mutex_t mutex)
{
    if(LOS_OK == LOS_MuxPend((UINT32)mutex,LOS_WAIT_FOREVER))
    {
        return true;
    }
    else
    {
        return false;
    }
}

//unlock the mutex
static bool_t  __mutex_unlock(mutex_t mutex)
{
    if(LOS_OK == LOS_MuxPost((UINT32)mutex))
    {
        return true;
    }
    else
    {
        return false;
    }
}
//delete the mutex
static bool_t  __mutex_del(mutex_t *mutex)
{
    if(LOS_OK == LOS_MuxDelete((UINT32)*mutex))
    {
        return true;
    }
    else
    {
        return false;
    }
}


///< this is implement for the semp
#include <los_sem.h>


//semp of the os
static bool_t  __semp_create(semp_t *semp,int limit,int initvalue)
{
    extern UINT32 osSemCreate (UINT16 usCount, UINT16 usMaxCount, UINT32 *puwSemHandle);
    if(LOS_OK == osSemCreate(initvalue,limit,(UINT32 *)semp))
    {
        return true;
    }
    else
    {
        return false;
    }
}
static bool_t  __semp_pend(semp_t semp,u32_t timeout)
{
    if(LOS_OK == LOS_SemPend((UINT32)semp,timeout))
    {
        return true;
    }
    else
    {
        return false;
    }
}
static bool_t  __semp_post(semp_t semp)
{
    if(LOS_OK == LOS_SemPost((UINT32)semp))
    {
        return true;
    }
    else
    {
        return false;
    }
}

static bool_t  __semp_del(semp_t *semp)
{
    if(LOS_OK == LOS_SemDelete((UINT32)*semp))
    {
        return true;
    }
    else
    {
        return false;
    }
}

///< this implement for the memory management
#include <los_memory.h>


static void *__mem_malloc(int size)
{
    void *ret = NULL;

    if(size > 0)
    {
         ret = LOS_MemAlloc(m_aucSysMem0,size);
    }

    return ret;
}

static void __mem_free(void *addr)
{
	LOS_MemFree(m_aucSysMem0,addr);
}

static const tag_os_ops s_liteos_ops =
{
	.task_sleep = __task_sleep,
	.task_create = __task_create,
	.task_kill = __task_kill,
	.task_exit = __task_exit,

	.mutex_create = __mutex_create,
	.mutex_lock = __mutex_lock,
	.mutex_unlock = __mutex_unlock,
	.mutex_del = __mutex_del,

	.semp_create = __semp_create,
	.semp_pend = __semp_pend,
	.semp_post = __semp_post,
	.semp_del = __semp_del,

	.malloc = __mem_malloc,
	.free = __mem_free,

};

static const tag_os s_link_liteos =
{
	.name = "LiteOS",
	.ops = &s_liteos_ops,
};

int link_liteos_install(void)
{
	int ret = -1;

	ret = osal_os_install(&s_link_liteos);

	return ret;
}






